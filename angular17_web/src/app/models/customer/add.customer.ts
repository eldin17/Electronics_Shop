import { AddAdress } from '../adress/add.adress';
import { AddPaymentMethod } from '../payment-method/add.payment.method';
import { AddPerson } from '../person/add.person';

export class AddCustomer {
  loyaltyPoints?: number;
  userAccountId!: number;
  adresses!: AddAdress[];
  paymentMethods!: AddPaymentMethod[];
  personId!: number;
  person!: AddPerson;
  isDeleted?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.loyaltyPoints = data.loyaltyPoints;
    this.userAccountId = data.userAccountId;
    this.adresses = Array.isArray(data.adresses)
      ? data.adresses.map((x: any) => new AddAdress(x))
      : [];
    this.paymentMethods = Array.isArray(data.paymentMethods)
      ? data.paymentMethods.map((x: any) => new AddPaymentMethod(x))
      : [];
    this.personId = data.personId;
    this.person = data.person ? new AddPerson(data.person) : undefined as any;
    this.isDeleted = data.isDeleted;
  }
}
