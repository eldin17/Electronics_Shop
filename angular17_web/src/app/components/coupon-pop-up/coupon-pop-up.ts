import { Component, EventEmitter, Input, Output } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CouponService } from '../../services/coupon.service';
import { AuthService } from '../../services/auth.service';

export interface AppliedCoupon {
  code: string;
  discountAmount: number;
}

type Feedback = { type: 'success' | 'error'; message: string };

@Component({
  selector: 'app-coupon-pop-up',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './coupon-pop-up.html',
  styleUrl: './coupon-pop-up.css',
})
export class CouponPopUp {

  @Input({ required: true }) purchaseAmount = 0;

  @Output() closed = new EventEmitter<void>();
  @Output() applied = new EventEmitter<AppliedCoupon>();

  couponCode = '';
  isChecking = false;
  feedback: Feedback | null = null;

  constructor(
    private couponService: CouponService,
    private authService: AuthService,
  ) {}

  onBackdropClick(): void {
    this.close();
  }

  close(): void {
    this.closed.emit();
  }

  onSubmit(): void {
    const code = this.couponCode.trim();
    if (!code || this.isChecking) return;

    const customerId = this.authService.getUserId();
    if (!customerId) {
      this.feedback = {
        type: 'error',
        message: 'You must be logged in to use a coupon.',
      };
      return;
    }

    this.isChecking = true;
    this.feedback = null;

    this.couponService
      .couponCheck({
        couponCode: code,
        customerId,
        purchaseAmount: this.purchaseAmount,
      })
      .subscribe({
        next: (coupon) => {
          this.isChecking = false;

          if (coupon?.id && coupon.id > 0) {
            const discountAmount = coupon.discountAmount ?? 0;
            this.feedback = {
              type: 'success',
              message: `🎉 Woohoo! You've got ${discountAmount}€ off! Enjoy the savings and happy shopping! 🛍️`,
            };
            this.applied.emit({ code, discountAmount });
          } else {
            this.feedback = {
              type: 'error',
              message: "Oops! 🚫 That coupon code doesn't look right. Double-check and try again!",
            };
          }
        },
        error: () => {
          this.isChecking = false;
          this.feedback = {
            type: 'error',
            message: "Oops! 🚫 That coupon code doesn't look right. Double-check and try again!",
          };
        },
      });
  }
}
