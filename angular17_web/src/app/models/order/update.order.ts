import { UpdateOrderItem } from '../order-item/update.order.item';

export class UpdateOrder {
  totalAmount?: number;
  adressId?: number;
  couponId?: number;
  paymentMethodId?: number;
  orderItems?: UpdateOrderItem[];

  constructor(data?: any) {
    if (!data) return;

    this.totalAmount = data.totalAmount;
    this.adressId = data.adressId;
    this.couponId = data.couponId;
    this.paymentMethodId = data.paymentMethodId;
    this.orderItems = Array.isArray(data.orderItems)
      ? data.orderItems.map((x: any) => new UpdateOrderItem(x))
      : [];
  }
}
