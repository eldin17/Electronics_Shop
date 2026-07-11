export class UpdateProductColor {
  name?: string;
  hexCode?: string;
  stock?: number;

  constructor(data?: any) {
    if (!data) return;

    this.name = data.name;
    this.hexCode = data.hexCode;
    this.stock = data.stock;
  }
}
