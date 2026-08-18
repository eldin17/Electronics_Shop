import {Component, OnInit, OnDestroy} from '@angular/core';
import {ProductCard} from '../../components/product-card/product-card';
import {ActivatedRoute} from '@angular/router';
import {Product} from '../../models/product/product';
import {ProductService} from '../../services/product.service';
import {AuthService} from '../../services/auth.service';

import {Subscription} from 'rxjs';
import {ProductSearchService} from '../../services/search.service';

@Component({
  selector: 'app-products',
  standalone: true,
  imports: [ProductCard],
  templateUrl: './products.html',
  styleUrl: './products.css'
})
export class Products implements OnInit, OnDestroy {
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

  filterVisible = false;
  filterSearchText = '';
  priceLow: number | null = null;
  priceHigh: number | null = null;
  selectedCategories = new Set<string>();
  availableCategories: string[] = [];

  private headerSearchSub?: Subscription;

  constructor(
    private route: ActivatedRoute,
    private productService: ProductService,
    private authService: AuthService,
    private productSearchService: ProductSearchService
  ) {}

  ngOnInit(): void {
  this.headerSearchSub = this.productSearchService.searchTerm$.subscribe(term => {
      this.filterSearchText = term;
      this.searchQuery = term;
      this.applyFilters();
    });

    const userAccId = this.authService.getUserId();

    this.route.queryParams.subscribe(params => {
      this.sortType = params['sort'] || 'all';
      this.searchQuery = params['search'] || '';
      this.filterSearchText = this.searchQuery;
      this.currentPage = 1;

      if (userAccId) {
        this.loadAllProducts(userAccId);
      } else {
        this.errorMessage = 'Please log in to view products.';
        this.isLoading = false;
      }
    });
  }

  ngOnDestroy(): void {
    this.headerSearchSub?.unsubscribe();
  }

  private loadAllProducts(userAccId: number): void {
    this.isLoading = true;
    this.productService.getAllWithChecksByUserAccId(userAccId).subscribe({
      next: (result) => {
        this.allProducts = result.data.map(item => new Product(item));
        this.availableCategories = Array.from(
          new Set(this.allProducts.map(p => p.productCategory.name).filter((c): c is string => !!c))
        );
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

    const q = this.filterSearchText.trim().toLowerCase();
    if (q) {
      tempProducts = tempProducts.filter(p => p.brand.toLowerCase().includes(q) || p.model.toLowerCase().includes(q));
    }

    if (this.selectedCategories.size > 0) {
      tempProducts = tempProducts.filter(p => p.productCategory.name && this.selectedCategories.has(p.productCategory.name));
    }

    if (this.priceLow != null) {
      tempProducts = tempProducts.filter(p => p.finalPrice >= this.priceLow!);
    }
    if (this.priceHigh != null) {
      tempProducts = tempProducts.filter(p => p.finalPrice <= this.priceHigh!);
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
    this.totalPages = Math.ceil(this.displayProducts.length / this.pageSize) || 1;
    if (this.currentPage > this.totalPages) {
      this.currentPage = 1;
    }
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

  toggleFilterSection(): void {
    this.filterVisible = !this.filterVisible;
  }

  onSearchInput(event: Event): void {
    this.filterSearchText = (event.target as HTMLInputElement).value;
  }

  onPriceLowInput(event: Event): void {
    const value = (event.target as HTMLInputElement).value;
    this.priceLow = value === '' ? null : Number(value);
  }

  onPriceHighInput(event: Event): void {
    const value = (event.target as HTMLInputElement).value;
    this.priceHigh = value === '' ? null : Number(value);
  }

  toggleCategory(category: string): void {
    if (this.selectedCategories.has(category)) {
      this.selectedCategories.delete(category);
    } else {
      this.selectedCategories.add(category);
    }
  }

  isCategorySelected(category: string): boolean {
    return this.selectedCategories.has(category);
  }

  get hasActiveFilters(): boolean {
    return !!this.filterSearchText || this.priceLow != null || this.priceHigh != null || this.selectedCategories.size > 0;
  }

  applyFilters(): void {
    if (this.priceLow != null && this.priceHigh != null &&
      this.priceHigh > 0 && this.priceLow > 0 && this.priceHigh < this.priceLow) {
      const temp = this.priceHigh;
      this.priceHigh = this.priceLow;
      this.priceLow = temp;
    }
    this.currentPage = 1;
    this.applySortingAndFiltering();
  }

  resetFilters(): void {
    this.filterSearchText = '';
    this.priceLow = null;
    this.priceHigh = null;
    this.selectedCategories.clear();
    this.currentPage = 1;
    this.applySortingAndFiltering();
  }
}
