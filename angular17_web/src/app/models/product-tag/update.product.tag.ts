export class UpdateProductTag {
  tag?: string;

  constructor(data?: any) {
    if (!data) return;

    this.tag = data.tag;
  }
}
