import { BaseSearch } from "../base.search";

export interface SearchShoppingCart extends BaseSearch {
  id?: number;
  customerId?: number;
  dateCreated?: Date;
}
