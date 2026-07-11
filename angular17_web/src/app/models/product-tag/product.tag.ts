export class ProductTag {
  id!: number;
  tag!: string;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.tag = data.tag;
  }
}
