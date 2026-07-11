import { BaseSearch } from "../base.search";

export interface SearchNews extends BaseSearch {
  id?: number;
  title?: string;
  content?: string;
  datePublished?: Date;
}
