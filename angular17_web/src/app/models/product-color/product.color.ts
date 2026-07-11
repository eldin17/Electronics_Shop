export class ProductColor {
  id!: number;
  productImageId!: number;
  name!: string;
  hexCode!: string;
  stock!: number;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.productImageId = data.productImageId;
    this.name = data.name;
    this.hexCode = data.hexCode;
    this.stock = data.stock;
  }
}
