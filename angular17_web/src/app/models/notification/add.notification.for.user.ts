export class AddNotificationForUser {
  title!: string;
  message!: string;
  dateCreated?: Date;
  isGeneral!: boolean;
  userAccIds!: number[];
}
