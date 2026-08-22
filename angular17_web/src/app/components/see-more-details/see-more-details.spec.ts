import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SeeMoreDetails } from './see-more-details';

describe('SeeMoreDetails', () => {
  let component: SeeMoreDetails;
  let fixture: ComponentFixture<SeeMoreDetails>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SeeMoreDetails],
    }).compileComponents();

    fixture = TestBed.createComponent(SeeMoreDetails);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
