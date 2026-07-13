import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Router } from '@angular/router';
import { Product } from '../../models/product/product';

@Component({
  selector: 'app-product-card',
  standalone: true,
  imports: [],
  templateUrl: './product-card.html',
  styleUrl: './product-card.css'
})
export class ProductCard {
  @Input({ required: true }) product!: Product;
  @Output() favoriteToggled = new EventEmitter<Product>();

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

  onCardClick(): void {
    this.router.navigate(['/product', this.product.id]);
  }

  onFavoriteClick(event: Event): void {
    event.stopPropagation();
    this.product.isFavourite = !this.product.isFavourite;
    this.favoriteToggled.emit(this.product);
  }
}
