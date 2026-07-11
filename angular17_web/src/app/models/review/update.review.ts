export class UpdateReview {
  rating?: number;
  comment?: string;

  constructor(data?: any) {
    if (!data) return;

    this.rating = data.rating;
    this.comment = data.comment;
  }
}
