import { Component, OnInit, ChangeDetectorRef, Optional } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { ProductService } from '../../services/product.service';
import { WishlistService } from '../../services/wishlist.service';
import { WishlistItemService } from '../../services/wishlist.item.service';
import { ShoppingCartService } from '../../services/shopping.cart.service';
import { ShoppingCartItemService } from '../../services/shopping.cart.item.service';
import { RecommendationsService } from '../../services/recommendations.service';
import { AiService } from '../../services/ai.service';
import { Product } from '../../models/product/product';

import { ProductCard } from '../../components/product-card/product-card';
import { SeeMoreDetails } from '../../components/see-more-details/see-more-details';
import { ProductImage } from '../../models/product-image/product.image';
import { ProductColor } from '../../models/product-color/product.color';
import { AddCartItem } from '../../models/cart-item/add.cart.item';

function normalizeHex(hex: string): string {
  let code = hex.trim().replace('#', '').toUpperCase();
  if (code.length === 6) {
    return `#${code}`;
  }
  if (code.length === 8) {
    return `#${code.substring(2)}`;
  }
  return '#d9d9d9';
}

@Component({
  selector: 'app-product-details',
  standalone: true,
  imports: [ProductCard, SeeMoreDetails],
  templateUrl: './product-details.html',
  styleUrl: './product-details.css',
})
export class ProductDetails implements OnInit {
  product: Product = new Product();
  imageList: ProductImage[] = [];
  selectedImageIndex = 0;
  recList: Product[] = [];

  selectedProductColor: ProductColor | null = null;
  wishlistItemId = 0;
  quantityInfo = 1;

  showSeeMoreDetails = false;

  showAiSummary = false;
  aiSummaryLoading = false;
  aiSummaryText = '';
  aiSummaryError = '';

  toastMessage = '';

  isLoading = true;
  errorMessage = '';

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private authService: AuthService,
    private productService: ProductService,
    private wishlistService: WishlistService,
    private wishlistItemService: WishlistItemService,
    private shoppingCartService: ShoppingCartService,
    private shoppingCartItemService: ShoppingCartItemService,
    @Optional() private recommendationsService: RecommendationsService | null,
    private aiService: AiService,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.route.paramMap.subscribe((params) => {
      const idParam = params.get('id');
      const productId = idParam ? Number(idParam) : null;

      const navState = this.router.getCurrentNavigation()?.extras.state
        ?? history.state;

      if (navState?.selectedColor) {
        this.selectedProductColor = navState.selectedColor as ProductColor;
      } else {
        this.selectedProductColor = null;
      }

      if (!productId) {
        this.errorMessage = 'Product not found.';
        this.isLoading = false;
        return;
      }

      this.initForm(productId);
    });
  }

  private initForm(productId: number): void {
    const userAccId = this.authService.getUserId();

    if (!userAccId) {
      this.errorMessage = 'You must be logged in to view this product.';
      this.isLoading = false;
      return;
    }

    this.isLoading = true;
    this.showAiSummary = false;
    this.aiSummaryText = '';
    window.scrollTo({ top: 0, behavior: 'smooth' });

    this.productService.getByIdWithChecks(userAccId, productId).subscribe({
      next: (result: any) => {
        const found = new Product(result.data ?? result);
        this.product = found;

        if (!this.selectedProductColor) {
          this.selectedProductColor = this.product.productColors?.[0] ?? null;
        }
        this.filterImagesForSelectedColor();

        this.isLoading = false;
        this.cdr.detectChanges();

        this.loadRecommendations(userAccId, productId);
      },
      error: (err) => {
        console.error('Failed to load product', err);
        this.errorMessage = 'Could not load this product.';
        this.isLoading = false;
        this.cdr.detectChanges();
      },
    });
  }

  private loadRecommendations(userAccId: number, productId: number): void {
    if (this.recommendationsService) {
      this.recommendationsService.getRecommendations(userAccId, productId, 4).subscribe({
        next: (products) => {
          this.recList = products;
          this.cdr.detectChanges();
        },
        error: (err) => console.error('Failed to load recommendations', err),
      });
      return;
    }

    this.productService.getAllWithChecksByUserAccId(userAccId).subscribe({
      next: (result) => {
        const allProducts = result.data.map((item) => new Product(item));
        this.recList = allProducts.filter((p) => p.id !== productId).slice(0, 4);
        this.cdr.detectChanges();
      },
      error: (err) => console.error('Failed to load recommendations fallback', err),
    });
  }

  private filterImagesForSelectedColor(): void {
    if (!this.selectedProductColor) {
      this.imageList = this.product.productImages ?? [];
    } else {
      this.imageList = (this.product.productImages ?? []).filter(
        (img) => img.productColor?.id === this.selectedProductColor?.id
      );
    }

    if (this.imageList.length === 0) {
      this.imageList = this.product.productImages ?? [];
    }

    this.selectedImageIndex = 0;
  }

  get selectedImage(): ProductImage | null {
    return this.imageList[this.selectedImageIndex] ?? null;
  }

  selectImage(index: number): void {
    this.selectedImageIndex = index;
  }

  colorHex(color: ProductColor): string {
    const hex = (color as any).hexCode ?? (color as any).hex ?? (color as any).colorCode;
    return hex ? normalizeHex(hex) : '#d9d9d9';
  }

  selectColor(color: ProductColor): void {
    this.selectedProductColor = color;
    this.filterImagesForSelectedColor();
  }

  incrementQty(): void {
    this.quantityInfo++;
  }

  decrementQty(): void {
    if (this.quantityInfo > 1) this.quantityInfo--;
  }

  openProduct(productId: number): void {
    this.selectedProductColor = null;
    this.router.navigate(['/products', productId]);
  }

  async toggleFavourite(): Promise<void> {
    const userAccId = this.authService.getUserId();

    if (!userAccId) {
      this.router.navigate(['/login']);
      return;
    }

    try {
      const wishlist = await this.wishlistService.getByUserId(userAccId).toPromise();
      const wishlistId = wishlist?.id;

      if (!wishlistId) {
        this.router.navigate(['/wishlist'], { state: { product: this.product } });
        return;
      }

      if (this.product.isFavourite) {
        await this.wishlistItemService
          .deleteByProductId(this.product.id!, wishlistId)
          .toPromise();
        this.showToast('Removed from Wishlist ❌');
      } else {
        const itemObj: any = await this.wishlistItemService
          .add({ productId: this.product.id, wishlistId })
          .toPromise();
        this.wishlistItemId = itemObj?.id ?? 0;
        this.showToast('Added to Wishlist ❤️');
      }

      this.product.isFavourite = !this.product.isFavourite;
      this.cdr.detectChanges();
    } catch (err) {
      console.error('Failed to update wishlist', err);
      this.showToast('Something went wrong. Please try again.');
    }
  }

  async addToCart(): Promise<void> {
    const userAccId = this.authService.getUserId();

    if (!userAccId) {
      this.router.navigate(['/login']);
      return;
    }

    try {
      const cart = await this.shoppingCartService.getByUserId(userAccId).toPromise();
      const shoppingCartId = cart?.id;

      if (!shoppingCartId) {
        this.router.navigate(['/cart'], { state: { product: this.product } });
        return;
      }

      await this.shoppingCartItemService.add(<AddCartItem>{
        quantity: this.quantityInfo,
        productId: this.product.id,
        shoppingCartId,
        productColorId: this.selectedProductColor?.id,
      }).toPromise();

      this.showToast('Added to Cart!');
    } catch (err) {
      console.error('Failed to add to cart', err);
      this.showToast('Could not add this item to your cart.');
    }
  }

  private showToast(message: string): void {
    this.toastMessage = message;
    this.cdr.detectChanges();
    setTimeout(() => {
      this.toastMessage = '';
      this.cdr.detectChanges();
    }, 2000);
  }

  openSeeMoreDetails(): void {
    this.showSeeMoreDetails = true;
  }

  closeSeeMoreDetails(): void {
    this.showSeeMoreDetails = false;
  }

  goToReviews(): void {
    if (!this.product?.id) return;

    this.router.navigate(['/products', this.product.id, 'reviews'], {
      state: { product: this.product },
    });
  }

  toggleAiSummary(): void {
    this.showAiSummary = !this.showAiSummary;
    if (this.showAiSummary && !this.aiSummaryText) {
      this.fetchAiSummary(false);
    }
  }

  fetchAiSummary(forceRefresh: boolean): void {
    if (this.product.id == null) {
      this.aiSummaryError = 'System could not resolve the Product ID.';
      return;
    }

    this.aiSummaryLoading = true;
    this.aiSummaryError = '';
    this.cdr.detectChanges();

    this.aiService.getProductReviewSummary({
      productId: this.product.id,
      forceRefresh,
    }).subscribe({
      next: (result) => {
        this.aiSummaryText = result.summary ?? 'No summary data found in the response.';
        this.aiSummaryLoading = false;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Failed to load AI summary', err);
        this.aiSummaryError = `Failed to load summary: ${err.message ?? err}`;
        this.aiSummaryLoading = false;
        this.cdr.detectChanges();
      },
    });
  }
}
