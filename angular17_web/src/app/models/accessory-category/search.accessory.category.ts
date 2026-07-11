import { BaseSearch } from "../base.search";

export interface SearchAccessoryCategory extends BaseSearch {
  id?: number;
  name?: string;
  isDeleted?: boolean;
}
