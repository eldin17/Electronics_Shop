import { BaseSearch } from "../base.search";

export interface SearchAdress extends BaseSearch {
  id?: number;
  street?: string;
  city?: string;
  country?: string;
  postalCode?: string;
  customerId?: number;
  personId?: number;
  isDeleted?: boolean;
}
