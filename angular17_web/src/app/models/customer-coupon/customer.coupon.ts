export class CustomerCoupon {
  id!: number;
  customerId!: number;
  couponId!: number;
  usageCount!: number;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.customerId = data.customerId;
    this.couponId = data.couponId;
    this.usageCount = data.usageCount;
  }
}
