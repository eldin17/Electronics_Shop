import { BaseSearch } from "../base.search";

export interface SearchWishlist extends BaseSearch {
  id?: number;
  customerId?: number;
  dateCreated?: Date;
}
