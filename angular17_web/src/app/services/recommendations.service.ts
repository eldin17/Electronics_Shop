import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { Product } from '../models/product/product';
import { MyConfig } from '../my-config';

@Injectable({ providedIn: 'root' })
export class RecommendationsService {
  private baseUrl = `${MyConfig.address}/api/Recommendation`;

  constructor(private http: HttpClient) {}

  getRecommendations(customerId: number, productId: number, take = 3): Observable<Product[]> {
    const params = new HttpParams()
      .set('customerId', customerId)
      .set('productId', productId)
      .set('take', take);

    return this.http
      .get<any[]>(this.baseUrl, { params })
      .pipe(map((data) => data.map((item) => new Product(item))));
  }
}
