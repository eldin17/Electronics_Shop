export class Coupon {
  id!: number;
  code!: string;
  discountAmount!: number;
  minPurchaseAmount!: number;
  maxUsagePerCustomer!: number;
  productCategoryId?: number;
  accessoryCategoryId?: number;
  startDate!: Date;
  endDate!: Date;
  isActive!: boolean;
  isDeleted!: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.code = data.code;
    this.discountAmount = data.discountAmount;
    this.minPurchaseAmount = data.minPurchaseAmount;
    this.maxUsagePerCustomer = data.maxUsagePerCustomer;
    this.productCategoryId = data.productCategoryId;
    this.accessoryCategoryId = data.accessoryCategoryId;
    this.startDate = data.startDate ? new Date(data.startDate) : undefined as any;
    this.endDate = data.endDate ? new Date(data.endDate) : undefined as any;
    this.isActive = data.isActive;
    this.isDeleted = data.isDeleted;
  }
}
