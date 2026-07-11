import { AddProductDiscount } from '../product-discount/add.product.discount';

export class AddDiscount {
  discountType!: string;
  amount!: number;
  startDate!: Date;
  endDate!: Date;
  isActive!: boolean;
  productDiscounts: AddProductDiscount[] = [];

  constructor(data?: any) {
    if (!data) return;

    this.discountType = data.discountType;
    this.amount = data.amount;
    this.startDate = data.startDate ? new Date(data.startDate) : undefined as any;
    this.endDate = data.endDate ? new Date(data.endDate) : undefined as any;
    this.isActive = data.isActive;
    this.productDiscounts = Array.isArray(data.productDiscounts)
      ? data.productDiscounts.map((x: any) => new AddProductDiscount(x))
      : [];
  }
}
