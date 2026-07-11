export class UpdateNotification {
  title?: string;
  message?: string;

  constructor(data?: any) {
    if (!data) return;

    this.title = data.title;
    this.message = data.message;
  }
}
