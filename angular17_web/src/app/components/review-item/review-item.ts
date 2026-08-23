import { Component, Input } from '@angular/core';
import { Review } from '../../models/review/review';

@Component({
  selector: 'app-review-item',
  standalone: true,
  imports: [],
  templateUrl: './review-item.html',
  styleUrl: './review-item.css',
})
export class ReviewItem {
  @Input({ required: true }) review!: Review;

  get reviewerName(): string {
    const customer = this.review.customer as any;
    if (!customer) return 'Anonymous';

    const first = customer.firstName ?? customer.person?.firstName;
    const last = customer.lastName ?? customer.person?.lastName;

    return [first, last].filter(Boolean).join(' ') || 'Anonymous';
  }

  get reviewerImage(): string | null {
    return this.review.image?.path ?? null;
  }

  get starsArray(): boolean[] {
    const rounded = Math.round(this.review.rating ?? 0);
    return [1, 2, 3, 4, 5].map((n) => n <= rounded);
  }
}
