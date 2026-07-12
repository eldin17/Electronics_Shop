import { CartItem } from '../cart-item/cart.item';

export class ShoppingCart {
  id!: number;
  customerId!: number;
  dateCreated!: Date;
  totalAmount?: number;
  cartItems: CartItem[] = [];

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.customerId = data.customerId;
    this.dateCreated = data.dateCreated ? new Date(data.dateCreated) : undefined as any;
    this.totalAmount = data.totalAmount;
    this.cartItems = Array.isArray(data.cartItems)
      ? data.cartItems.map((x: any) => new CartItem(x))
      : [];
  }
}
