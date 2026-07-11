import { BaseSearch } from "../base.search";

export interface SearchCoupon extends BaseSearch {
  id?: number;
  code?: string;
  discountAmount?: number;
  minPurchaseAmount?: number;
  maxUsagePerCustomer?: number;
  productCategoryId?: number;
  accessoryCategoryId?: number;
  startDate?: Date;
  endDate?: Date;
  isActive?: boolean;
  isDeleted?: boolean;
}
