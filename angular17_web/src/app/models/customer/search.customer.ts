import { BaseSearch } from "../base.search";

export interface SearchCustomer extends BaseSearch {
  id?: number;
  loyaltyPoints?: number;
  minLoyaltyPoints?: number;
  userAccountId?: number;
  personId?: number;
}
