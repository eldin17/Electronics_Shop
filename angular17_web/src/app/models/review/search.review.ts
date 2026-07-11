import { BaseSearch } from "../base.search";

export interface SearchReview extends BaseSearch {
  id?: number;
  rating?: number;
  comment?: string;
  customerId?: number;
  productId?: number;
}
