export class AddByCartReq {
  cartId!: number;
  couponId?: number;

  constructor(data?: any) {
    if (!data) return;

    this.cartId = data.cartId;
    this.couponId = data.couponId;
  }
}
