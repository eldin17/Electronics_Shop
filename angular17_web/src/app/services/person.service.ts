import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {firstValueFrom, map, Observable} from 'rxjs';

import {Pagination} from '../models/pagination';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';


import {BYPASS_LOADING} from './loading/loading.interceptor';
import {Person} from '../models/person/person';
import {SearchPerson} from '../models/person/search.person';
import {AddPerson} from '../models/person/add.person';
import {UpdatePerson} from '../models/person/update.person';
import {Wishlist} from '../models/wishlist/wishlist';


@Injectable({ providedIn: 'root' })
export class PersonService extends BaseCRUDProvider<Person, SearchPerson, AddPerson, UpdatePerson> {
  private apiUrl = `${MyConfig.address}/api/Person`;

  constructor(http: HttpClient) {
    super(http, 'Person');
  }

  fromJson(data: any): Person {
    return new Person(data);
  }

  getByUserId(userAccId: number): Observable<Person> {
    const url = `${this.apiUrl}/GetByUserId/${userAccId}`;
    return this.http.get<any>(url).pipe(map((data) => this.fromJson(data)));
  }
}
