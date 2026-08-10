import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {firstValueFrom, Observable} from 'rxjs';

import {Pagination} from '../models/pagination';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';

import {BYPASS_LOADING} from './loading/loading.interceptor';
import {Customer} from '../models/customer/customer';
import {SearchCustomer} from '../models/customer/search.customer';
import {AddCustomer} from '../models/customer/add.customer';
import {UpdateCustomer} from '../models/customer/update.customer';


@Injectable({ providedIn: 'root' })
export class CustomerService extends BaseCRUDProvider<Customer, SearchCustomer, AddCustomer, UpdateCustomer> {
  private apiUrl = `${MyConfig.address}/api/Customer`;

  constructor(http: HttpClient) {
    super(http, 'Customer');
  }

  fromJson(data: any): Customer {
    return new Customer(data);
  }
}
