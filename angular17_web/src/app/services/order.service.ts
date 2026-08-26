import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {firstValueFrom, Observable} from 'rxjs';

import {Pagination} from '../models/pagination';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';


import {BYPASS_LOADING} from './loading/loading.interceptor';
import {Order} from '../models/order/order';
import {SearchOrder} from '../models/order/search.order';
import {AddOrder} from '../models/order/add.order';
import {UpdateOrder} from '../models/order/update.order';

import {CheckAndActivateReq} from '../models/order/check.and.activate.req';
import {OrderSuggestion} from '../models/order/helpers/order.suggestion';
import {AddByCartReq} from '../models/cart-item/add.by.cart.req';




@Injectable({ providedIn: 'root' })
export class OrderService extends BaseCRUDProvider<Order, SearchOrder, AddOrder, UpdateOrder> {
  private apiUrl = `${MyConfig.address}/api/Order`;

  constructor(http: HttpClient) {
    super(http, 'Order');
  }

  fromJson(data: any): Order {
    return new Order(data);
  }


  confirm(id: number, cartId: number): Observable<OrderSuggestion> {
    const params = new HttpParams().set('cartId', cartId);
    return this.http.patch<OrderSuggestion>(
      `${this.baseUrl}${this.endpoint}/Confirm/${id}`,
      {},
      { params }
    );
  }

  confirmStripe(id: number, cartId: number): Observable<OrderSuggestion> {
    const params = new HttpParams().set('cartId', cartId);
    return this.http.patch<OrderSuggestion>(
      `${this.baseUrl}${this.endpoint}/ConfirmStripe/${id}`,
      {},
      { params }
    );
  }

  backToDraft(id: number): Observable<Order> {
    return this.http.patch<Order>(
      `${this.baseUrl}${this.endpoint}/BackToDraft/${id}`,
      {}
    );
  }

  addItem(id: number, productColorId: number, quantity: number): Observable<Order> {
    const params = new HttpParams()
      .set('productColorId', productColorId)
      .set('quantity', quantity);
    return this.http.patch<Order>(
      `${this.baseUrl}${this.endpoint}/AddItem/${id}`,
      {},
      { params }
    );
  }

  removeItem(id: number, itemId: number): Observable<Order> {
    const params = new HttpParams().set('itemId', itemId);
    return this.http.patch<Order>(
      `${this.baseUrl}${this.endpoint}/RemoveItem/${id}`,
      {},
      { params }
    );
  }

  checkAndActivate(req: CheckAndActivateReq): Observable<OrderSuggestion> {
    return this.http.post<OrderSuggestion>(
      `${this.baseUrl}${this.endpoint}/CheckAndActivate`,
      req
    );
  }

  applyCoupon(id: number, couponId: number): Observable<Order> {
    const params = new HttpParams().set('couponId', couponId);
    return this.http.patch<Order>(
      `${this.baseUrl}${this.endpoint}/ApplyCoupon/${id}`,
      {},
      { params }
    );
  }

  allowedActionsInState(id: number): Observable<string[]> {
    return this.http.get<string[]>(
      `${this.baseUrl}${this.endpoint}/AllowedActionsInState/${id}`
    );
  }

  addByCart(request: AddByCartReq): Observable<Order> {
    return this.http.post<Order>(
      `${this.baseUrl}${this.endpoint}/AddByCart`,
      request
    );
  }

  deleteOrderAndCoupon(id: number): Observable<Order> {
    return this.http.delete<Order>(
      `${this.baseUrl}${this.endpoint}/DeleteOrderAndCoupon/${id}`
    );
  }
}
