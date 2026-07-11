import { Adress } from '../adress/adress';
import { Person } from '../person/person';

export class Seller {
  id!: number;
  storeName!: string;
  licenseNumber!: number;
  adress!: Adress;
  userAccountId!: number;
  person!: Person;
  isDeleted!: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.storeName = data.storeName;
    this.licenseNumber = data.licenseNumber;
    this.adress = data.adress ? new Adress(data.adress) : undefined as any;
    this.userAccountId = data.userAccountId;
    this.person = data.person ? new Person(data.person) : undefined as any;
    this.isDeleted = data.isDeleted;
  }
}
