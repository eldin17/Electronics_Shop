export class PaymentMethod {
  id!: number;
  code!: string;
  type!: string;
  provider!: string;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.code = data.code;
    this.type = data.type;
    this.provider = data.provider;
  }
}
