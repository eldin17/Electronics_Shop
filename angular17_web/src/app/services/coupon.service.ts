import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {firstValueFrom, Observable} from 'rxjs';
import {Pagination} from '../models/pagination';
import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';

import {BYPASS_LOADING} from './loading/loading.interceptor';
import {Coupon} from '../models/coupon/coupon';
import {SearchCoupon} from '../models/coupon/search.coupon';
import {AddCoupon} from '../models/coupon/add.coupon';
import {UpdateCoupon} from '../models/coupon/update.coupon';


@Injectable({ providedIn: 'root' })
export class CouponService extends BaseCRUDProvider<Coupon, SearchCoupon, AddCoupon, UpdateCoupon> {
  private apiUrl = `${MyConfig.address}/api/Coupon`;

  constructor(http: HttpClient) {
    super(http, 'Coupon');
  }

  fromJson(data: any): Coupon {
    return new Coupon(data);
  }

  couponCheck(params: {
    couponCode: string;
    customerId: number;
    purchaseAmount: number;
  }): Observable<Coupon> {
    const httpParams = new HttpParams()
      .set('couponCode', params.couponCode)
      .set('customerId', params.customerId.toString())
      .set('purchaseAmount', params.purchaseAmount.toString());

    return this.http.get<Coupon>(`${this.apiUrl}/CouponCheck`, {
      params: httpParams,
    });
  }
}
