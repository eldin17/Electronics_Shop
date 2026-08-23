import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../services/auth.service';

import { ProductService } from '../../services/product.service';
import { Product } from '../../models/product/product';
import { Review } from '../../models/review/review';
import { AddReview } from '../../models/review/add.review';
import { SearchReview } from '../../models/review/search.review';
import { Pagination } from '../../models/pagination';
import { ReviewService } from '../../services/reviews.service';
import {ReviewItem} from '../../components/review-item/review-item';


@Component({
  selector: 'app-reviews',
  standalone: true,
  imports: [FormsModule, ReviewItem],
  templateUrl: './reviews.html',
  styleUrl: './reviews.css',
})
export class Reviews implements OnInit {
  product: Product = new Product();
  reviews: Review[] = [];

  isLoading = true;
  errorMessage = '';

  newComment = '';
  newRating = 0;
  hoverRating = 0;
  isSubmitting = false;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private authService: AuthService,
    private reviewService: ReviewService,
    private productService: ProductService,
    private cdr: ChangeDetectorRef,
  ) {}

  ngOnInit(): void {
    const idParam = this.route.snapshot.paramMap.get('id');
    const productId = idParam ? Number(idParam) : null;

    const navState = this.router.getCurrentNavigation()?.extras.state
      ?? history.state;

    if (navState?.product) {
      this.product = navState.product as Product;
    }

    if (!productId) {
      this.errorMessage = 'Product not found.';
      this.isLoading = false;
      return;
    }

    if (!this.product?.id) {
      this.loadProduct(productId);
    }

    this.loadReviews(productId);
  }

  private loadProduct(productId: number): void {
    const userAccId = this.authService.getUserId();
    if (!userAccId) return;

    this.productService.getByIdWithChecks(userAccId, productId).subscribe({
      next: (result: any) => {
        this.product = new Product(result.data ?? result);
        this.cdr.detectChanges();
      },
      error: (err) => console.error('Failed to load product', err),
    });
  }

  private loadReviews(productId: number): void {
    this.isLoading = true;

    this.reviewService.getAll({ productId } as SearchReview).subscribe({
      next: (result: Pagination<Review>) => {
        this.reviews = result?.data ?? [];
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Failed to load reviews', err);
        this.errorMessage = 'Could not load reviews.';
        this.isLoading = false;
        this.cdr.detectChanges();
      },
    });
  }

  goBack(): void {
    if (this.product?.id) {
      this.router.navigate(['/products', this.product.id]);
    } else {
      this.router.navigate(['/']);
    }
  }

  setRating(value: number): void {
    this.newRating = value;
  }

  setHoverRating(value: number): void {
    this.hoverRating = value;
  }

  clearHoverRating(): void {
    this.hoverRating = 0;
  }

  postReview(): void {
    const userAccId = this.authService.getUserId();

    if (!userAccId) {
      this.router.navigate(['/login']);
      return;
    }

    if (!this.newRating || !this.newComment.trim() || !this.product?.id) {
      return;
    }

    this.isSubmitting = true;

    this.reviewService.add(new AddReview({
      productId: this.product.id,
      customerId: userAccId,
      rating: this.newRating,
      comment: this.newComment.trim(),
    })).subscribe({
      next: () => {
        this.newComment = '';
        this.newRating = 0;
        this.isSubmitting = false;
        this.loadReviews(this.product.id!);
      },
      error: (err) => {
        console.error('Failed to post review', err);
        this.isSubmitting = false;
        this.cdr.detectChanges();
      },
    });
  }
}
