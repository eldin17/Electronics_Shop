import { BaseSearch } from "../base.search";

export interface SearchAccessoryProperty extends BaseSearch {
  id?: number;
  propertyName?: string;
  accessoryId?: number;
}
