export class UpdateCartItem {

  quantity?: number;
  productId?: number;

  constructor(data?: any) {
    if (!data) return;


    this.quantity = data.quantity;
    this.productId = data.productId;
  }
}
