import { BaseSearch } from "../base.search";

export interface SearchProductDiscount extends BaseSearch {
  id?: number;
  productId?: number;
  discountId?: number;
}
