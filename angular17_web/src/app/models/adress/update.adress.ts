export class UpdateAdress {
  street?: string;
  city?: string;
  country?: string;
  postalCode?: string;
  isDeleted?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.street = data.street;
    this.city = data.city;
    this.country = data.country;
    this.postalCode = data.postalCode;
    this.isDeleted = data.isDeleted;
  }
}
