export class AddReview {
  rating!: number;
  comment!: string;
  customerId!: number;
  productId!: number;

  constructor(data?: any) {
    if (!data) return;

    this.rating = data.rating;
    this.comment = data.comment;
    this.customerId = data.customerId;
    this.productId = data.productId;
  }
}
