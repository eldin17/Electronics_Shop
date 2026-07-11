import { UpdateAdress } from '../adress/update.adress';

export class UpdateSeller {
  storeName?: string;
  licenseNumber?: number;
  adress?: UpdateAdress;
  userAccountId?: number;
  personId?: number;
  isDeleted?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.storeName = data.storeName;
    this.licenseNumber = data.licenseNumber;
    this.adress = data.adress ? new UpdateAdress(data.adress) : undefined;
    this.userAccountId = data.userAccountId;
    this.personId = data.personId;
    this.isDeleted = data.isDeleted;
  }
}
