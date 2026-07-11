import { BaseSearch } from "../base.search";

export interface SearchSeller extends BaseSearch {
  id?: number;
  storeName?: string;
  licenseNumber?: number;
  adressId?: number;
  userAccountId?: number;
  personId?: number;
  isDeleted?: boolean;
}
