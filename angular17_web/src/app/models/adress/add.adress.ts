export class AddAdress {
  street!: string;
  city!: string;
  country!: string;
  postalCode!: string;
  personId!: number;
  customerId!: number;
  isDeleted?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.street = data.street;
    this.city = data.city;
    this.country = data.country;
    this.postalCode = data.postalCode;
    this.personId = data.personId;
    this.customerId = data.customerId;
    this.isDeleted = data.isDeleted;
  }
}
