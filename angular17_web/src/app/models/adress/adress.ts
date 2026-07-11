export class Adress {
  id!: number;
  street!: string;
  city!: string;
  country!: string;
  postalCode!: string;
  isDeleted!: boolean;
  customerId!: number;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.street = data.street;
    this.city = data.city;
    this.country = data.country;
    this.postalCode = data.postalCode;
    this.isDeleted = data.isDeleted;
    this.customerId = data.customerId;
  }
}
