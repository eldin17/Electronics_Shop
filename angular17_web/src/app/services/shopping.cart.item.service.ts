import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';


import {map, Observable} from 'rxjs';
import {CartItem} from '../models/cart-item/cart.item';
import {SearchCartItem} from '../models/cart-item/search.cart.item';
import {AddCartItem} from '../models/cart-item/add.cart.item';
import {UpdateCartItem} from '../models/cart-item/update.cart.item';


@Injectable({ providedIn: 'root' })
export class ShoppingCartItemService extends BaseCRUDProvider<CartItem, SearchCartItem, AddCartItem, UpdateCartItem> {
  private apiUrl = `${MyConfig.address}/api/CartItem`;

  constructor(http: HttpClient) {
    super(http, 'CartItem');
  }

  fromJson(data: any): CartItem {
    return new CartItem(data);
  }
}
