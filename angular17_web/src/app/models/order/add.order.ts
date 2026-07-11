import { AddOrderItem } from '../order-item/add.order.item';

export class AddOrder {
  orderTime?: Date;
  totalAmount!: number;
  stateMachine?: string;
  customerId!: number;
  adressId!: number;
  couponId?: number;
  paymentMethodId!: number;
  orderItems!: AddOrderItem[];
  paymentId?: string;
  paymentIntent?: string;

  constructor(data?: any) {
    if (!data) return;

    this.orderTime = data.orderTime ? new Date(data.orderTime) : undefined;
    this.totalAmount = data.totalAmount;
    this.stateMachine = data.stateMachine;
    this.customerId = data.customerId;
    this.adressId = data.adressId;
    this.couponId = data.couponId;
    this.paymentMethodId = data.paymentMethodId;
    this.orderItems = Array.isArray(data.orderItems)
      ? data.orderItems.map((x: any) => new AddOrderItem(x))
      : [];
    this.paymentId = data.paymentId;
    this.paymentIntent = data.paymentIntent;
  }
}
