import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {firstValueFrom, Observable} from 'rxjs';

import {Pagination} from '../models/pagination';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';


import {BYPASS_LOADING} from './loading/loading.interceptor';
import {OrderItem} from '../models/order-item/order.item';
import {SearchOrderItem} from '../models/order-item/search.order.item';
import {AddOrderItem} from '../models/order-item/add.order.item';
import {UpdateOrderItem} from '../models/order-item/update.order.item';

@Injectable({ providedIn: 'root' })
export class OrderItemService extends BaseCRUDProvider<OrderItem, SearchOrderItem, AddOrderItem, UpdateOrderItem> {
  private apiUrl = `${MyConfig.address}/api/OrderItem`;

  constructor(http: HttpClient) {
    super(http, 'OrderItem');
  }

  fromJson(data: any): OrderItem {
    return new OrderItem(data);
  }
}
