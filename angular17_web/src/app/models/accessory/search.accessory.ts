import { BaseSearch } from "../base.search";

export interface SearchAccessory extends BaseSearch {
  id?: number;
  name?: string;
  description?: string;
  accessoryCategoryId?: number;
}
