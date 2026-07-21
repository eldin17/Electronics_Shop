import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProductCard2 } from './product-card-2';

describe('ProductCard2', () => {
  let component: ProductCard2;
  let fixture: ComponentFixture<ProductCard2>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ProductCard2],
    }).compileComponents();

    fixture = TestBed.createComponent(ProductCard2);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
