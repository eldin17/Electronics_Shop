import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { MyConfig } from '../my-config';

export interface ProductReviewSummary {
  productId: number;
  summary: string;
}

@Injectable({ providedIn: 'root' })
export class AiService {
  private baseUrl = `${MyConfig.address}/api/SummaryAI`;

  constructor(private http: HttpClient) {}

  getProductReviewSummary(options: { productId: number; forceRefresh?: boolean }): Observable<ProductReviewSummary> {
    const { productId, forceRefresh = false } = options;
    const params = new HttpParams().set('forceRefresh', forceRefresh);

    return new Observable<ProductReviewSummary>((subscriber) => {
      this.http
        .get<any>(`${this.baseUrl}/${productId}/reviews-summary`, { params })
        .subscribe({
          next: (result) => {
            subscriber.next({
              productId: result.productId ?? result.ProductId,
              summary: result.summary ?? result.Summary,
            });
            subscriber.complete();
          },
          error: (err) => subscriber.error(err),
        });
    });
  }
}
