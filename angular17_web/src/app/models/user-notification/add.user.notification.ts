export class AddUserNotification {
  userAccountId!: number;
  notificationId!: number;
  isRead?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.userAccountId = data.userAccountId;
    this.notificationId = data.notificationId;
    this.isRead = data.isRead;
  }
}
