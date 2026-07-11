import { BaseSearch } from "../base.search";

export interface SearchOrderItem extends BaseSearch {
  id?: number;
  quantity?: number;
  price?: number;
  finalPrice?: number;
  orderId?: number;
}
