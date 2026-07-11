export class UpdateOrderItem {
  id?: number;
  quantity?: number;
  price?: number;
  orderId?: number;
  productId?: number;
  finalPrice?: number;
  productColorId?: number;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.quantity = data.quantity;
    this.price = data.price;
    this.orderId = data.orderId;
    this.productId = data.productId;
    this.finalPrice = data.finalPrice;
    this.productColorId = data.productColorId;
  }
}
