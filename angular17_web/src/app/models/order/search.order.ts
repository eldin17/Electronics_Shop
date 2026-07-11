import { BaseSearch } from "../base.search";

export interface SearchOrder extends BaseSearch {
  id?: number;
  minOrderTime?: Date;
  maxOrderTime?: Date;
  totalAmount?: number;
  maxTotalAmount?: number;
  minTotalAmount?: number;
  customerId?: number;
  adressId?: number;
  couponId?: number;
  paymentMethodId?: number;
}
