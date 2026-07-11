import { WishlistItem } from '../wishlist-item/wishlist.item';

export class Wishlist {
  id!: number;
  customerId!: number;
  dateCreated!: Date;
  wishlistItems: WishlistItem[] = [];

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.customerId = data.customerId;
    this.dateCreated = data.dateCreated ? new Date(data.dateCreated) : undefined as any;
    this.wishlistItems = Array.isArray(data.wishlistItems)
      ? data.wishlistItems.map((x: any) => new WishlistItem(x))
      : [];
  }
}
