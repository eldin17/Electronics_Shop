import { Component, OnInit, ChangeDetectorRef } from '@angular/core';

import { WishlistService } from '../../services/wishlist.service';

import { AuthService } from '../../services/auth.service';
import { ProductCard2 } from '../../components/product-card-2/product-card-2';
import { WishlistItem } from '../../models/wishlist-item/wishlist.item';
import { WishlistItemService } from '../../services/wishlist.item.service';

@Component({
  selector: 'app-wishlist-screen',
  standalone: true,
  imports: [ProductCard2],
  templateUrl: './wishlist.html',
  styleUrl: './wishlist.css',
})
export class WishlistScreen implements OnInit {
  items: WishlistItem[] = [];
  wishlistId?: number;
  isLoading = true;
  errorMessage = '';

  constructor(
    private wishlistService: WishlistService,
    private wishlistItemService: WishlistItemService,
    private authService: AuthService,
    private cdr: ChangeDetectorRef,
  ) {}

  ngOnInit(): void {
    const userAccId = this.authService.getUserId();

    if (userAccId) {
      this.loadWishlist(userAccId);
    } else {
      this.authService.refresh().subscribe({
        next: () => {
          const refreshedId = this.authService.getUserId();
          if (refreshedId) {
            this.loadWishlist(refreshedId);
          } else {
            this.handleAuthError();
          }
        },
        error: () => this.handleAuthError(),
      });
    }
  }

  private loadWishlist(userAccId: number): void {
    this.isLoading = true;

    this.wishlistService.getByUserId(userAccId).subscribe({
      next: (wishlist) => {
        this.wishlistId = wishlist.id;
        this.items = wishlist.wishlistItems ?? [];
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Failed to load wishlist', err);
        this.errorMessage = 'Could not load your wishlist.';
        this.isLoading = false;
        this.cdr.detectChanges();
      },
    });
  }

  private handleAuthError(): void {
    this.errorMessage = 'You must be logged in to view your wishlist.';
    this.isLoading = false;
    this.cdr.detectChanges();
  }

  onRemove(itemId: number): void {
    if (!this.wishlistId) return;

    const previousItems = this.items;
    this.items = this.items.filter((i) => i.id !== itemId);

    this.wishlistItemService.delete(itemId).subscribe({
      error: (err) => {
        console.error('Failed to remove item', err);
        this.items = previousItems;
        this.cdr.detectChanges();
      },
    });
  }


}
