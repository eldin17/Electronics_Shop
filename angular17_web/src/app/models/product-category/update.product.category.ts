export class UpdateProductCategory {
  name?: string;
  isDeleted?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.name = data.name;
    this.isDeleted = data.isDeleted;
  }
}
