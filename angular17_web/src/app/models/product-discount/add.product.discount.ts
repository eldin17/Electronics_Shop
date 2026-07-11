export class AddProductDiscount {
  productId!: number;
  discountId!: number;

  constructor(data?: any) {
    if (!data) return;

    this.productId = data.productId;
    this.discountId = data.discountId;
  }
}
