import { BaseSearch } from "../base.search";

export interface SearchWarranty extends BaseSearch {
  id?: number;
  period_mm?: number;
  coverageDetails?: string;
  productId?: number;
}
