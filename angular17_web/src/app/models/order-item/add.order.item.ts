export class AddOrderItem {
  quantity!: number;
  price!: number;
  orderId!: number;
  productId!: number;
  finalPrice!: number;
  productColorId!: number;

  constructor(data?: any) {
    if (!data) return;

    this.quantity = data.quantity;
    this.price = data.price;
    this.orderId = data.orderId;
    this.productId = data.productId;
    this.finalPrice = data.finalPrice;
    this.productColorId = data.productColorId;
  }
}
