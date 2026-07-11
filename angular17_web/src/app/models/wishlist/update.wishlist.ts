import { UpdateWishlistItem } from '../wishlist-item/update.wishlist.item';

export class UpdateWishlist {
  customerId?: number;
  wishlistItems?: UpdateWishlistItem[];

  constructor(data?: any) {
    if (!data) return;

    this.customerId = data.customerId;
    this.wishlistItems = Array.isArray(data.wishlistItems)
      ? data.wishlistItems.map((x: any) => new UpdateWishlistItem(x))
      : undefined;
  }
}
