import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class ProductSearchService {
  private searchTermSource = new Subject<string>();
  searchTerm$ = this.searchTermSource.asObservable();

  setTerm(term: string): void {
    this.searchTermSource.next(term);
  }
}
