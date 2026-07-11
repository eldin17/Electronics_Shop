import { BaseSearch } from "../base.search";

export interface SearchNotification extends BaseSearch {
  id?: number;
  title?: string;
  message?: string;
  dateCreated?: Date;
  isGeneral?: boolean;
}
