import {ChangeDetectorRef, Component, OnInit} from '@angular/core';
import {WishlistItem} from '../../models/wishlist-item/wishlist.item';
import {WishlistService} from '../../services/wishlist.service';
import {WishlistItemService} from '../../services/wishlist.item.service';
import {AuthService} from '../../services/auth.service';
import {CartItem} from '../../models/cart-item/cart.item';
import {ShoppingCartService} from '../../services/shopping.cart.service';
import {ShoppingCartItemService} from '../../services/shopping.cart.item.service';
import {ProductCard2} from '../../components/product-card-2/product-card-2';

@Component({
  selector: 'app-shopping-cart',
  imports: [
    ProductCard2
  ],
  templateUrl: './shopping-cart.html',
  styleUrl: './shopping-cart.css',
})
export class ShoppingCart implements OnInit {
  items: CartItem[] = [];
  cartId?: number;
  isLoading = true;
  errorMessage = '';

  appliedCoupon: { code: string; discountAmount: number } | null = null;

  constructor(
    private shoppingCartService: ShoppingCartService,
    private cartItemService: ShoppingCartItemService,
    private authService: AuthService,
    private cdr: ChangeDetectorRef,
  ) {}

  ngOnInit(): void {
    const userAccId = this.authService.getUserId();

    if (userAccId) {
      this.loadShoppingCart(userAccId);
    } else {
      this.authService.refresh().subscribe({
        next: () => {
          const refreshedId = this.authService.getUserId();
          if (refreshedId) {
            this.loadShoppingCart(refreshedId);
          } else {
            this.handleAuthError();
          }
        },
        error: () => this.handleAuthError(),
      });
    }
  }

  private loadShoppingCart(userAccId: number): void {
    this.isLoading = true;

    this.shoppingCartService.getByUserId(userAccId).subscribe({
      next: (cart) => {
        this.cartId = cart.id;
        this.items = cart.cartItems ?? [];
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Failed to load shopping cart', err);
        this.errorMessage = 'Could not load your shopping cart.';
        this.isLoading = false;
        this.cdr.detectChanges();
      },
    });
  }

  private handleAuthError(): void {
    this.errorMessage = 'You must be logged in to view your shopping cart.';
    this.isLoading = false;
    this.cdr.detectChanges();
  }

  get subtotal(): number {
    return this.items.reduce(
      (sum, item) => sum + (item.product?.finalPrice ?? 0) * (item.quantity ?? 1),
      0,
    );
  }

  get total(): number {
    const discount = this.appliedCoupon?.discountAmount ?? 0;
    return Math.max(this.subtotal - discount, 0);
  }

  onRemove(itemId: number): void {
    if (!this.cartId) return;

    const previousItems = this.items;
    this.items = this.items.filter((i) => i.id !== itemId);

    this.cartItemService.delete(itemId).subscribe({
      error: (err) => {
        console.error('Failed to remove item', err);
        this.items = previousItems;
        this.cdr.detectChanges();
      },
    });
  }

  onAddCoupon(): void {
    console.log('Add coupon code');
  }

  onCheckout(): void {
    console.log('Check Out ->', this.total, '€');
  }
}
