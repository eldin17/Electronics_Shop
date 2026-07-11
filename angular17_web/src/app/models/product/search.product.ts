import { BaseSearch } from "../base.search";

export interface SearchProduct extends BaseSearch {
  id?: number;
  fullTextSearch?: string;
  fullTextCategorySearch?: string;
  brand?: string;
  model?: string;
  description?: string;
  priceLow?: number;
  priceHigh?: number;
  allColorsStock?: number;
  productCategoryId?: number;
  productProductTags?: number[];
  isDeleted?: boolean;
}
