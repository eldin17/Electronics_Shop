import { BaseSearch } from "../base.search";

export interface SearchCustomerCoupon extends BaseSearch {
  id?: number;
  customerId?: number;
  couponId?: number;
  usageCount?: number;
}
