import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Product } from '../../models/product/product';
import { Router } from '@angular/router';

@Component({
  selector: 'app-product-card-2',
  imports: [],
  templateUrl: './product-card-2.html',
  styleUrl: './product-card-2.css',
})
export class ProductCard2 {
  @Input({ required: true }) product!: Product;
  @Output() remove = new EventEmitter<number>();
  @Output() addToCart = new EventEmitter<number>();

  constructor(private router: Router) {}

  get displayName(): string {
    return `${this.product.brand} ${this.product.model}`;
  }

  get imageUrl(): string {
    return this.product.productImages?.[0]?.image.path ?? '/assets/images/Logo2.jpg';
  }

  get hasDiscount(): boolean {
    return this.product.finalPrice < this.product.price;
  }

  onDelete(event: MouseEvent): void {
    event.stopPropagation();
    this.remove.emit(this.product.id);
  }

  openProduct(event: MouseEvent): void {
    event.stopPropagation();
    console.log('Opening product card ->', this.product.id);
  }
}
