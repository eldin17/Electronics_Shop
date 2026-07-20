import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NotifCard } from './notif-card';

describe('NotifCard', () => {
  let component: NotifCard;
  let fixture: ComponentFixture<NotifCard>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [NotifCard],
    }).compileComponents();

    fixture = TestBed.createComponent(NotifCard);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
