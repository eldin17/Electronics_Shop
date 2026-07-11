export class AddWishlistItem {
  productId!: number;
  wishlistId!: number;

  constructor(data?: any) {
    if (!data) return;

    this.productId = data.productId;
    this.wishlistId = data.wishlistId;
  }
}
