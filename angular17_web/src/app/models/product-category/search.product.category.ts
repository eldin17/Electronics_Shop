import { BaseSearch } from "../base.search";

export interface SearchProductCategory extends BaseSearch {
  id?: number;
  name?: string;
  isDeleted?: boolean;
}
