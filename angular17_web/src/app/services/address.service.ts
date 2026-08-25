import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {firstValueFrom, Observable} from 'rxjs';

import {Pagination} from '../models/pagination';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';


import {BYPASS_LOADING} from './loading/loading.interceptor';
import {Adress} from '../models/adress/adress';
import {SearchAdress} from '../models/adress/search.adress';
import {AddAdress} from '../models/adress/add.adress';
import {UpdateAdress} from '../models/adress/update.adress';



@Injectable({ providedIn: 'root' })
export class AddressService extends BaseCRUDProvider<Adress, SearchAdress, AddAdress, UpdateAdress> {
  private apiUrl = `${MyConfig.address}/api/Adress`;

  constructor(http: HttpClient) {
    super(http, 'Adress');
  }

  fromJson(data: any): Adress {
    return new Adress(data);
  }


}
