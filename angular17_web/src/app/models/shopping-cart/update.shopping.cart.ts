import { UpdateCartItem } from '../cart-item/update.cart.item';

export class UpdateShoppingCart {
  cartItems?: UpdateCartItem[];

  constructor(data?: any) {
    if (!data) return;

    this.cartItems = Array.isArray(data.cartItems)
      ? data.cartItems.map((x: any) => new UpdateCartItem(x))
      : undefined;
  }
}
