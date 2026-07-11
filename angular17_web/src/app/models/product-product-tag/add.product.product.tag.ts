export class AddProductProductTag {
  productId!: number;
  productTagId!: number;

  constructor(data?: any) {
    if (!data) return;

    this.productId = data.productId;
    this.productTagId = data.productTagId;
  }
}
