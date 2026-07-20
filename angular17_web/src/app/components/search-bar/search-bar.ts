import { Component, EventEmitter, Output } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-search-bar',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './search-bar.html',
  styleUrl: './search-bar.css'
})
export class SearchBar {
  query: string = '';

  @Output() search = new EventEmitter<string>();

  constructor(private router: Router) {}

  onSearch(): void {
    const trimmed = this.query.trim();
    if (!trimmed) return;

    this.search.emit(trimmed);
    this.router.navigate(['/products'], { queryParams: { search: trimmed } });
  }

  onClear(): void {
    this.query = '';
  }
}
