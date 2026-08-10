import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CouponPopUp } from './coupon-pop-up';

describe('CouponPopUp', () => {
  let component: CouponPopUp;
  let fixture: ComponentFixture<CouponPopUp>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CouponPopUp],
    }).compileComponents();

    fixture = TestBed.createComponent(CouponPopUp);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
