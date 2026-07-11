export class AddPerson {
  firstName!: string;
  lastName!: string;
  dateOfBirth!: Date;

  constructor(data?: any) {
    if (!data) return;

    this.firstName = data.firstName;
    this.lastName = data.lastName;
    this.dateOfBirth = data.dateOfBirth ? new Date(data.dateOfBirth) : undefined as any;
  }
}
