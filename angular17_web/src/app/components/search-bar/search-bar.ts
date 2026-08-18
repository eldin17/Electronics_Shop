import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { Location } from '@angular/common';
import {ProductSearchService} from '../../services/search.service';


@Component({
  selector: 'app-search-bar',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './search-bar.html',
  styleUrl: './search-bar.css'
})
export class SearchBar {
  query: string = '';

  constructor(
    private router: Router,
    private location: Location,
    private searchService: ProductSearchService
  ) {}

  private get isOnProductsPage(): boolean {
    return this.router.url.split('?')[0] === '/products';
  }

  onSearch(): void {
    const trimmed = this.query.trim();
    if (!trimmed) return;

    if (this.isOnProductsPage) {
      this.searchService.setTerm(trimmed);
      this.updateUrlSilently(trimmed);
    } else {
      this.router.navigate(['/products'], { queryParams: { search: trimmed } });
    }
  }

  onClear(): void {
    this.query = '';

    if (this.isOnProductsPage) {
      this.searchService.setTerm('');
      this.updateUrlSilently('');
    }
  }

  private updateUrlSilently(term: string): void {
    const urlTree = this.router.createUrlTree(['/products'], {
      queryParams: { search: term || null },
      queryParamsHandling: 'merge'
    });
    this.location.replaceState(this.router.serializeUrl(urlTree));
  }
}
