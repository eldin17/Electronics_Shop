import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InfoDetails } from './info-details';

describe('InfoDetails', () => {
  let component: InfoDetails;
  let fixture: ComponentFixture<InfoDetails>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [InfoDetails],
    }).compileComponents();

    fixture = TestBed.createComponent(InfoDetails);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
