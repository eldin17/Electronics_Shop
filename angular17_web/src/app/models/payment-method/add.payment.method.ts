export class AddPaymentMethod {
  code!: string;
  type!: string;
  provider!: string;

  constructor(data?: any) {
    if (!data) return;

    this.code = data.code;
    this.type = data.type;
    this.provider = data.provider;
  }
}
