export class UpdateWarranty {
  period_mm?: number;
  coverageDetails?: string;

  constructor(data?: any) {
    if (!data) return;

    this.period_mm = data.period_mm;
    this.coverageDetails = data.coverageDetails;
  }
}
