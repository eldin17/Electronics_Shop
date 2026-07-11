import {Order} from '../order/order';


export class OrderSuggestion {
  sessionId?: string;
  oldOrder!: Order;
  newOrder!: Order;

  constructor(data?: any) {
    if (!data) return;

    this.sessionId = data.sessionId;
    this.oldOrder = data.oldOrder ? new Order(data.oldOrder) : undefined as any;
    this.newOrder = data.newOrder ? new Order(data.newOrder) : undefined as any;
  }
}
