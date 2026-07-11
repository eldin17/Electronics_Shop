import { BaseSearch } from "../base.search";

export interface SearchCartItem extends BaseSearch {
  id?: number;
  quantity?: number;
  minQuantity?: number;
  productId?: number;
  shoppingCartId?: number;
}
