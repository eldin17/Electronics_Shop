export class UpdateCustomer {
  loyaltyPoints?: number;
  isDeleted?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.loyaltyPoints = data.loyaltyPoints;
    this.isDeleted = data.isDeleted;
  }
}
