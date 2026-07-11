export class Notification {
  id!: number;
  title!: string;
  message!: string;
  dateCreated!: Date;
  isGeneral!: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.title = data.title;
    this.message = data.message;
    this.dateCreated = data.dateCreated ? new Date(data.dateCreated) : undefined as any;
    this.isGeneral = data.isGeneral;
  }
}
