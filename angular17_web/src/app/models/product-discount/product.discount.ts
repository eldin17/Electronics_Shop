export class ProductDiscount {
  id!: number;
  productId!: number;
  discountId!: number;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.productId = data.productId;
    this.discountId = data.discountId;
  }
}
