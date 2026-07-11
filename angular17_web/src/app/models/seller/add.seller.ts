export class AddSeller {
  storeName!: string;
  licenseNumber!: number;
  adressId!: number;
  userAccountId!: number;
  personId!: number;
  isDeleted?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.storeName = data.storeName;
    this.licenseNumber = data.licenseNumber;
    this.adressId = data.adressId;
    this.userAccountId = data.userAccountId;
    this.personId = data.personId;
    this.isDeleted = data.isDeleted;
  }
}
