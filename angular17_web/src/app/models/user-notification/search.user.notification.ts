import { BaseSearch } from "../base.search";

export interface SearchUserNotification extends BaseSearch {
  id?: number;
  userAccountId?: number;
  notificationId?: number;
  isRead?: boolean;
}
