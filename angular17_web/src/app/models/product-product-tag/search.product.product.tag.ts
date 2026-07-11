import { BaseSearch } from "../base.search";

export interface SearchProductProductTag extends BaseSearch {
  id?: number;
  productId?: number;
  productTagId?: number;
}
