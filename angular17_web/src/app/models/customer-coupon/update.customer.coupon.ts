export class UpdateCustomerCoupon {
  customerId?: number;
  couponId?: number;
  usageCount?: number;

  constructor(data?: any) {
    if (!data) return;

    this.customerId = data.customerId;
    this.couponId = data.couponId;
    this.usageCount = data.usageCount;
  }
}
