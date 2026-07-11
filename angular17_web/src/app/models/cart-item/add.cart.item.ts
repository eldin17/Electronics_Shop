export class AddCartItem {
  quantity!: number;
  productId!: number;
  shoppingCartId!: number;
  productColorId!: number;

  constructor(data?: any) {
    if (!data) return;

    this.quantity = data.quantity;
    this.productId = data.productId;
    this.shoppingCartId = data.shoppingCartId;
    this.productColorId = data.productColorId;
  }
}
