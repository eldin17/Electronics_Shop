import {ProductDiscount} from '../product-discount/product.discount';
import {Product} from '../product/product';

export class Discount {
  id!: number;
  discountType!: string;
  amount!: number;
  startDate!: Date;
  endDate!: Date;
  isActive!: boolean;
  productDiscounts: ProductDiscount[] = [];
  notAppliedList: Product[] = [];

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.discountType = data.discountType;
    this.amount = data.amount;
    this.startDate = data.startDate ? new Date(data.startDate) : undefined as any;
    this.endDate = data.endDate ? new Date(data.endDate) : undefined as any;
    this.isActive = data.isActive;
    this.productDiscounts = Array.isArray(data.productDiscounts)
      ? data.productDiscounts.map((x: any) => new ProductDiscount(x))
      : [];
    this.notAppliedList = Array.isArray(data.notAppliedList)
      ? data.notAppliedList.map((x: any) => new Product(x))
      : [];
  }
}
