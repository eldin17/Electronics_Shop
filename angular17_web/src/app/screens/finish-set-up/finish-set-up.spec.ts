import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FinishSetUp } from './finish-set-up';

describe('FinishSetUp', () => {
  let component: FinishSetUp;
  let fixture: ComponentFixture<FinishSetUp>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FinishSetUp],
    }).compileComponents();

    fixture = TestBed.createComponent(FinishSetUp);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
