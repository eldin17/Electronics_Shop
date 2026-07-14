import {Component, OnInit, ChangeDetectorRef, ViewChildren, QueryList, ElementRef} from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';
import { ProductCard } from '../../components/product-card/product-card';
import { Product } from '../../models/product/product';
import { ProductService } from '../../services/product.service';
import { FormsModule } from '@angular/forms';
import {News} from '../../models/news/news';
import {NewsService} from '../../services/news.service';
import {NewsCard} from '../../components/news-card/news-card';

@Component({
  selector: 'app-home',
  imports: [ProductCard, FormsModule, NewsCard,],
  templateUrl: './home.html',
  styleUrl: './home.css',
})
export class Home implements OnInit {
  latestProducts: Product[] = [];
  discountProducts: Product[] = [];

  isLoading = true;
  errorMessage = '';

  newsList: News[] = [];

  constructor(
    private authService: AuthService,
    private productService: ProductService,
    private newsService: NewsService,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    const userAccId = this.authService.getUserId();

    if (userAccId) {

      this.loadProducts(userAccId);
      this.loadNews();
    } else {

      this.authService.refresh().subscribe({
        next: () => {
          const refreshedId = this.authService.getUserId();
          if (refreshedId) {
            this.loadProducts(refreshedId);
          } else {
            this.handleAuthError();
          }
        },
        error: () => this.handleAuthError()
      });
      this.loadNews();
    }
  }

  private loadProducts(userAccId: number): void {
    this.isLoading = true;

    this.productService.getAllWithChecksByUserAccId(userAccId).subscribe({
      next: (result) => {
        const allProducts = result.data.map(item => new Product(item));



        setTimeout(() => {
          this.latestProducts = allProducts
            .slice()
            .sort((a, b) => b.id - a.id)
            .slice(0, 6);

          this.discountProducts = allProducts
            .filter(p => p.finalPrice !== p.price)
            .slice(0, 6);

          this.isLoading = false;


          this.cdr.detectChanges();
        });
      },
      error: (err) => {
        console.error('Failed to load products', err);
        setTimeout(() => {
          this.errorMessage = 'Could not load products.';
          this.isLoading = false;
          this.cdr.detectChanges();
        });
      }
    });
  }

  private loadNews(): void {
    this.newsService.getAll().subscribe({
      next: (result) => {
        this.newsList = result.data
          .slice()
          .sort((a: any, b: any) => b.id - a.id)
          .slice(0, 6)
          .map((item: any) => new News(item));
        this.cdr.detectChanges();
      },
      error: (err) => console.error('Failed to load news', err)
    });
  }

  private handleAuthError(): void {
    this.errorMessage = 'You must be logged in to view products.';
    this.isLoading = false;
    this.cdr.detectChanges();
  }

  onFavoriteToggled(product: Product): void {
    console.log('Toggled favorite for', product.id, product.isFavourite);
  }
}
