import {Discount} from '../discount/discount';


export class DiscountSuggestion {
  oldDiscount!: Discount;
  newDiscount!: Discount;

  constructor(data?: any) {
    if (!data) return;

    this.oldDiscount = data.oldDiscount ? new Discount(data.oldDiscount) : undefined as any;
    this.newDiscount = data.newDiscount ? new Discount(data.newDiscount) : undefined as any;
  }
}
