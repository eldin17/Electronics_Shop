import { Adress } from '../adress/adress';
import { Coupon } from '../coupon/coupon';
import { PaymentMethod } from '../payment-method/payment.method';
import { OrderItem } from '../order-item/order.item';

export class Order {
  id!: number;
  orderTime!: Date;
  totalAmount!: number;
  finalTotalAmount?: number;
  stateMachine!: string;
  adress!: Adress;
  couponId?: number;
  coupon?: Coupon;
  paymentMethod!: PaymentMethod;
  orderItems: OrderItem[] = [];

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.orderTime = data.orderTime ? new Date(data.orderTime) : undefined as any;
    this.totalAmount = data.totalAmount;
    this.finalTotalAmount = data.finalTotalAmount;
    this.stateMachine = data.stateMachine;
    this.adress = data.adress ? new Adress(data.adress) : undefined as any;
    this.couponId = data.couponId;
    this.coupon = data.coupon ? new Coupon(data.coupon) : undefined;
    this.paymentMethod = data.paymentMethod ? new PaymentMethod(data.paymentMethod) : undefined as any;
    this.orderItems = Array.isArray(data.orderItems)
      ? data.orderItems.map((x: any) => new OrderItem(x))
      : [];
  }
}
