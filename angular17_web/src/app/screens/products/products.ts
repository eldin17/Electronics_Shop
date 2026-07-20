import {Component, OnInit} from '@angular/core';
import {ProductCard} from '../../components/product-card/product-card';
import {ActivatedRoute, RouterLink} from '@angular/router';
import {Product} from '../../models/product/product';
import {ProductService} from '../../services/product.service';
import {AuthService} from '../../services/auth.service';

@Component({
  selector: 'app-products',
  standalone: true,
  imports: [ProductCard, RouterLink],
  templateUrl: './products.html',
  styleUrl: './products.css'
})
export class Products implements OnInit {
  allProducts: Product[] = [];
  displayProducts: Product[] = [];
  paginatedProducts: Product[] = [];

  isLoading = true;
  errorMessage = '';
  sortType: 'latest' | 'discount' | 'all' = 'all';
  searchQuery = '';

  currentPage = 1;
  pageSize = 10;
  totalPages = 1;

  constructor(
    private route: ActivatedRoute,
    private productService: ProductService,
    private authService: AuthService
  ) {}

  ngOnInit(): void {
    const userAccId = this.authService.getUserId();

    this.route.queryParams.subscribe(params => {
      this.sortType = params['sort'] || 'all';
      this.searchQuery = params['search'] || '';
      this.currentPage = 1;

      if (userAccId) {
        this.loadAllProducts(userAccId);
      } else {
        this.errorMessage = 'Please log in to view products.';
        this.isLoading = false;
      }
    });
  }

  private loadAllProducts(userAccId: number): void {
    this.isLoading = true;
    this.productService.getAllWithChecksByUserAccId(userAccId).subscribe({
      next: (result) => {
        this.allProducts = result.data.map(item => new Product(item));
        this.applySortingAndFiltering();
        this.isLoading = false;
      },
      error: (err) => {
        console.error('Failed to load products', err);
        this.errorMessage = 'Could not load products.';
        this.isLoading = false;
      }
    });
  }

  private applySortingAndFiltering(): void {
    let tempProducts = [...this.allProducts];

    if (this.searchQuery) {
      const q = this.searchQuery.toLowerCase();
      tempProducts = tempProducts.filter(p => p.brand.toLowerCase().includes(q) || p.model.toLowerCase().includes(q));
    }

    if (this.sortType === 'latest') {
      tempProducts.sort((a, b) => b.id - a.id);
    }
    else if (this.sortType === 'discount') {

      const discounted = tempProducts
        .filter(p => p.finalPrice !== p.price)
        .sort((a, b) => b.id - a.id);

      const nonDiscounted = tempProducts
        .filter(p => p.finalPrice === p.price)
        .sort((a, b) => b.id - a.id);

      tempProducts = [...discounted, ...nonDiscounted];
    }

    this.displayProducts = tempProducts;
    this.totalPages = Math.ceil(this.displayProducts.length / this.pageSize);
    this.updatePageData();
  }

  updatePageData(): void {
    const startIndex = (this.currentPage - 1) * this.pageSize;
    const endIndex = startIndex + this.pageSize;
    this.paginatedProducts = this.displayProducts.slice(startIndex, endIndex);
  }

  setPage(page: number): void {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
      this.updatePageData();
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
  }

  getPagesArray(): number[] {
    return Array.from({ length: this.totalPages }, (_, i) => i + 1);
  }
}
