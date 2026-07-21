import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';

import {map, Observable} from 'rxjs';
import {ShoppingCart} from '../models/shopping-cart/shopping.cart';
import {SearchShoppingCart} from '../models/shopping-cart/search.shopping.cart';
import {AddShoppingCart} from '../models/shopping-cart/add.shopping.cart';
import {UpdateShoppingCart} from '../models/shopping-cart/update.shopping.cart';

@Injectable({ providedIn: 'root' })
export class ShoppingCartService extends BaseCRUDProvider<ShoppingCart, SearchShoppingCart, AddShoppingCart, UpdateShoppingCart> {
  private apiUrl = `${MyConfig.address}/api/ShoppingCart`;

  constructor(http: HttpClient) {
    super(http, 'ShoppingCart');
  }

  fromJson(data: any): ShoppingCart {
    return new ShoppingCart(data);
  }

  getByUserId(userAccId: number): Observable<ShoppingCart> {
    const url = `${this.apiUrl}/GetByUserId/${userAccId}`;
    return this.http.get<any>(url).pipe(map((data) => this.fromJson(data)));
  }
}
