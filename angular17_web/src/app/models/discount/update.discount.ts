export class UpdateDiscount {
  discountType?: string;
  amount?: number;
  startDate?: Date;
  endDate?: Date;
  isActive?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.discountType = data.discountType;
    this.amount = data.amount;
    this.startDate = data.startDate ? new Date(data.startDate) : undefined;
    this.endDate = data.endDate ? new Date(data.endDate) : undefined;
    this.isActive = data.isActive;
  }
}
