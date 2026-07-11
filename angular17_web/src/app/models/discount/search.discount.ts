import { BaseSearch } from "../base.search";

export interface SearchDiscount extends BaseSearch {
  id?: number;
  discountType?: string;
  amount?: number;
  startDate?: Date;
  endDate?: Date;
  isActive?: boolean;
}
