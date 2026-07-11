import { BaseSearch } from "../base.search";

export interface SearchProductTag extends BaseSearch {
  id?: number;
  tag?: string;
}
