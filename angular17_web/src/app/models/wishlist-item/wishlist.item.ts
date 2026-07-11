import { Product } from '../product/product';

export class WishlistItem {
  id!: number;
  product!: Product;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.product = data.product ? new Product(data.product) : undefined as any;
  }
}
