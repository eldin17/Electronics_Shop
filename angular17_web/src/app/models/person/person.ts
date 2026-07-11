export class Person {
  id!: number;
  firstName!: string;
  lastName!: string;
  dateOfBirth!: Date;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.firstName = data.firstName;
    this.lastName = data.lastName;
    this.dateOfBirth = data.dateOfBirth ? new Date(data.dateOfBirth) : undefined as any;
  }
}
