import { BaseSearch } from "../base.search";

export interface SearchWishlistItem extends BaseSearch {
  id?: number;
  productId?: number;
  wishlistId?: number;
}
