export class Warranty {
  id!: number;
  period_mm!: number;
  coverageDetails!: string;
  productId!: number;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.period_mm = data.period_mm;
    this.coverageDetails = data.coverageDetails;
    this.productId = data.productId;
  }
}
