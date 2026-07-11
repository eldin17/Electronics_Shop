export class UpdateWishlistItem {
  id?: number;
  productId?: number;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.productId = data.productId;
  }
}
