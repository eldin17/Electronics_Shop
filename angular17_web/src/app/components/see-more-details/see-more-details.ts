import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Product } from '../../models/product/product';
import { SpecSection } from './spec-builders/shared';
import { phoneSections } from './spec-builders/phone';
import { tabletSections } from './spec-builders/tablet';
import { laptopSections } from './spec-builders/laptop';
import { desktopPCSections } from './spec-builders/desktop-pc';
import { gamingConsoleSections } from './spec-builders/gaming-console';
import { televisionSections } from './spec-builders/television';
import { cameraSections } from './spec-builders/camera';
import { accessorySections } from './spec-builders/accessory';

@Component({
  selector: 'app-see-more-details',
  imports: [],
  templateUrl: './see-more-details.html',
  styleUrl: './see-more-details.css',
})
export class SeeMoreDetails {
  @Input({ required: true }) product!: Product;
  @Output() closed = new EventEmitter<void>();

  close(): void {
    this.closed.emit();
  }

  get categoryName(): string | undefined {
    return (this.product as any).productCategory?.name;
  }

  get specSections(): SpecSection[] {
    const p = this.product as any;

    switch (this.categoryName) {
      case 'Phone':
        return phoneSections(p.phone ?? {});
      case 'Tablet':
        return tabletSections(p.tablet ?? {});
      case 'Laptop':
        return laptopSections(p.laptop ?? {});
      case 'Desktop PC':
        return desktopPCSections(p.desktopPC ?? {});
      case 'Gaming Console':
        return gamingConsoleSections(p.gamingConsole ?? {});
      case 'Television':
        return televisionSections(p.television ?? {});
      case 'Camera':
        return cameraSections(p.camera ?? {});
      case 'Accessory':
        return accessorySections(p.accessory ?? {});
      default:
        return [];
    }
  }
}
