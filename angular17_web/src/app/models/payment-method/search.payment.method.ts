import { BaseSearch } from "../base.search";

export interface SearchPaymentMethod extends BaseSearch {
  id?: number;
  code?: string;
  type?: string;
  provider?: string;
}
