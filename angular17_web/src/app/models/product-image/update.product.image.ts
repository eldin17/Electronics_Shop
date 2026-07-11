export class UpdateProductImage {
  imageId?: number;
  productColorId?: number;

  constructor(data?: any) {
    if (!data) return;

    this.imageId = data.imageId;
    this.productColorId = data.productColorId;
  }
}
