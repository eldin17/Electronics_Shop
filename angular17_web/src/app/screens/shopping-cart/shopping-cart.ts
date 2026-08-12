import {ChangeDetectorRef, Component, OnInit} from '@angular/core';
import {WishlistItem} from '../../models/wishlist-item/wishlist.item';
import {WishlistService} from '../../services/wishlist.service';
import {WishlistItemService} from '../../services/wishlist.item.service';
import {AuthService} from '../../services/auth.service';
import {CartItem} from '../../models/cart-item/cart.item';
import {ShoppingCartService} from '../../services/shopping.cart.service';
import {ShoppingCartItemService} from '../../services/shopping.cart.item.service';
import {ProductCard2} from '../../components/product-card-2/product-card-2';
import {CouponPopUp, AppliedCoupon} from '../../components/coupon-pop-up/coupon-pop-up';

@Component({
  selector: 'app-shopping-cart',
  imports: [
    ProductCard2,
    CouponPopUp
  ],
  templateUrl: './shopping-cart.html',
  styleUrl: './shopping-cart.css',
})
export class ShoppingCart implements OnInit {
  items: CartItem[] = [];
  cartId?: number;
  isLoading = true;
  errorMessage = '';

  appliedCoupon: AppliedCoupon | null = null;
  showCouponPopup = false;

  constructor(
    private shoppingCartService: ShoppingCartService,
    private cartItemService: ShoppingCartItemService,
    private authService: AuthService,
    private cdr: ChangeDetectorRef,
  ) {}

  ngOnInit(): void {
    const userAccId = this.authService.getUserId()!;
    this.loadShoppingCart(userAccId);
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

  resolveItemImage(item: CartItem): string {
    const images = item.product?.productImages ?? [];

    const match = images.find(
      (img) => img.productColor?.id === item.productColorId,
    );

    return (match ?? images[0])?.image?.path ?? '';
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
    this.showCouponPopup = true;
  }

  onCouponApplied(coupon: AppliedCoupon): void {
    this.appliedCoupon = coupon;
    this.showCouponPopup = false;
  }

  onCouponPopupClosed(): void {
    this.showCouponPopup = false;
  }

  onCheckout(): void {
    console.log('Check Out ->', this.total, '€');
  }
}
