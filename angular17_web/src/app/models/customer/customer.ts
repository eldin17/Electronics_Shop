import {Adress} from '../adress/adress';
import {PaymentMethod} from '../payment-method/payment.method';
import {Person} from '../person/person';
import {Order} from '../order/order';
import {ShoppingCart} from '../shopping-cart/shopping.cart';
import {Wishlist} from '../wishlist/wishlist';


export class Customer {
  id!: number;
  loyaltyPoints!: number;
  userAccountId!: number;

  adresses: Adress[] = [];
  wishlist?: Wishlist;
  shoppingCart?: ShoppingCart;
  paymentMethods: PaymentMethod[] = [];
  person!: Person;
  isDeleted!: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.loyaltyPoints = data.loyaltyPoints;
    this.userAccountId = data.userAccountId;

    this.adresses = Array.isArray(data.adresses)
      ? data.adresses.map((x: any) => new Adress(x))
      : [];
    this.wishlist = data.wishlist ? new Wishlist(data.wishlist) : undefined;
    this.shoppingCart = data.shoppingCart ? new ShoppingCart(data.shoppingCart) : undefined;
    this.paymentMethods = Array.isArray(data.paymentMethods)
      ? data.paymentMethods.map((x: any) => new PaymentMethod(x))
      : [];
    this.person = data.person ? new Person(data.person) : undefined as any;
    this.isDeleted = data.isDeleted;
  }
}
