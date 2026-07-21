import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';
import {Wishlist} from '../models/wishlist/wishlist';
import {SearchWishlist} from '../models/wishlist/search.wishlist';
import {AddWishlist} from '../models/wishlist/add.wishlist';
import {UpdateWishlist} from '../models/wishlist/update.wishlist';
import {map, Observable} from 'rxjs';

@Injectable({ providedIn: 'root' })
export class WishlistService extends BaseCRUDProvider<Wishlist, SearchWishlist, AddWishlist, UpdateWishlist> {
  private apiUrl = `${MyConfig.address}/api/Wishlist`;

  constructor(http: HttpClient) {
    super(http, 'Wishlist');
  }

  fromJson(data: any): Wishlist {
    return new Wishlist(data);
  }

  getByUserId(userAccId: number): Observable<Wishlist> {
    const url = `${this.apiUrl}/GetByUserId/${userAccId}`;
    return this.http.get<any>(url).pipe(map((data) => this.fromJson(data)));
  }
}
