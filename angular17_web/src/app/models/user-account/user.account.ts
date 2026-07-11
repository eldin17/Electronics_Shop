import { Customer } from '../customer/customer';
import { Seller } from '../seller/seller';
import { Role } from '../role/role';
import { Image } from '../image/image';

export class UserAccount {
  id!: number;
  username!: string;
  email!: string;
  registrationDate!: Date;
  customer?: Customer;
  seller?: Seller;
  role!: Role;
  image!: Image;
  isDeactivated!: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.username = data.username;
    this.email = data.email;
    this.registrationDate = data.registrationDate ? new Date(data.registrationDate) : undefined as any;
    this.customer = data.customer ? new Customer(data.customer) : undefined;
    this.seller = data.seller ? new Seller(data.seller) : undefined;
    this.role = data.role ? new Role(data.role) : undefined as any;
    this.image = data.image ? new Image(data.image) : undefined as any;
    this.isDeactivated = data.isDeactivated;
  }
}
