export class AddNotification {
  title!: string;
  message!: string;
  dateCreated?: Date;
  isGeneral!: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.title = data.title;
    this.message = data.message;
    this.dateCreated = data.dateCreated ? new Date(data.dateCreated) : undefined;
    this.isGeneral = data.isGeneral;
  }
}
