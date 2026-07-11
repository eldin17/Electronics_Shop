import { BaseSearch } from "../base.search";

export interface SearchPerson extends BaseSearch {
  id?: number;
  firstName?: string;
  lastName?: string;
  dateOfBirth?: Date;
}
