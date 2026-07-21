import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';

import {WishlistItem} from '../models/wishlist-item/wishlist.item';
import {SearchWishlistItem} from '../models/wishlist-item/search.wishlist.item';
import {AddWishlistItem} from '../models/wishlist-item/add.wishlist.item';
import {UpdateWishlistItem} from '../models/wishlist-item/update.wishlist.item';
import {map, Observable} from 'rxjs';


@Injectable({ providedIn: 'root' })
export class WishlistItemService extends BaseCRUDProvider<WishlistItem, SearchWishlistItem, AddWishlistItem, UpdateWishlistItem> {
  private apiUrl = `${MyConfig.address}/api/WishlistItem`;

  constructor(http: HttpClient) {
    super(http, 'WishlistItem');
  }

  fromJson(data: any): WishlistItem {
    return new WishlistItem(data);
  }

  deleteByProductId(productId: number, wishlistId: number): Observable<WishlistItem> {
    const url = `${this.apiUrl}/DeleteByProductId`;
    const params = new HttpParams()
      .set('productId', productId)
      .set('wishlistId', wishlistId);

    return this.http
      .delete<any>(url, { params })
      .pipe(map((data) => this.fromJson(data)));
  }
}
