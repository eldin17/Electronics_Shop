import { BaseSearch } from "../base.search";

export interface SearchProductColor extends BaseSearch {
  id?: number;
  name?: string;
  hexCode?: string;
  stock?: number;
}
