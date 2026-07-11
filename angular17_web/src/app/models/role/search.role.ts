import { BaseSearch } from "../base.search";

export interface SearchRole extends BaseSearch {
  id?: number;
  roleName?: string;
  isDeleted?: boolean;
}
