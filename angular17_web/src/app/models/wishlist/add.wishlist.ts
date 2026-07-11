export class AddWishlist {
  customerId!: number;
  dateCreated?: Date;

  constructor(data?: any) {
    if (!data) return;

    this.customerId = data.customerId;
    this.dateCreated = data.dateCreated ? new Date(data.dateCreated) : undefined;
  }
}
