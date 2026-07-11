export class UserNotification {
  id!: number;
  userAccountId!: number;
  notificationId!: number;
  isRead!: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.userAccountId = data.userAccountId;
    this.notificationId = data.notificationId;
    this.isRead = data.isRead;
  }
}
