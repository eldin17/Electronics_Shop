import { BaseSearch } from "../base.search";

export interface SearchUserAccount extends BaseSearch {
  id?: number;
  username?: string;
  email?: string;
  roleId?: number;
  isDeactivated?: boolean;
}
