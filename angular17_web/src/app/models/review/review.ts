import { Customer } from '../customer/customer';
import { Image } from '../image/image';

export class Review {
  id!: number;
  rating!: number;
  comment!: string;
  customer!: Customer;
  productId!: number;
  image!: Image;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.rating = data.rating;
    this.comment = data.comment;
    this.customer = data.customer ? new Customer(data.customer) : undefined as any;
    this.productId = data.productId;
    this.image = data.image ? new Image(data.image) : undefined as any;
  }
}
