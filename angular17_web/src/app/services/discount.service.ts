import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import {map, Observable} from 'rxjs';

import {Pagination} from '../models/pagination';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';
import {Discount} from '../models/discount/discount';
import {SearchDiscount} from '../models/discount/search.discount';
import {AddDiscount} from '../models/discount/add.discount';
import {UpdateDiscount} from '../models/discount/update.discount';


@Injectable({ providedIn: 'root' })
export class DiscountService extends BaseCRUDProvider<Discount, SearchDiscount, AddDiscount, UpdateDiscount> {
  private apiUrl = `${MyConfig.address}/api/Discount`;

  constructor(http: HttpClient) {
    super(http, 'Discount');
  }

  fromJson(data: any): Discount {
    return new Discount(data);
  }

  getOneRandom(): Observable<Discount> {
    return this.http.get<any>(`${this.apiUrl}/GetOneRandom`).pipe(
      map(data => this.fromJson(data))
    );
  }
}
