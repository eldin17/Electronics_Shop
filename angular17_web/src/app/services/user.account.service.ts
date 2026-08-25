import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {firstValueFrom, Observable} from 'rxjs';

import {Pagination} from '../models/pagination';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';


import {BYPASS_LOADING} from './loading/loading.interceptor';
import {UserAccount} from '../models/user-account/user.account';
import {SearchUserAccount} from '../models/user-account/search.user.account';
import {AddUserAccount} from '../models/user-account/add.user.account';
import {UpdateUserAccount} from '../models/user-account/update.user.account';


@Injectable({ providedIn: 'root' })
export class UserAccountService extends BaseCRUDProvider<UserAccount, SearchUserAccount, AddUserAccount, UpdateUserAccount> {
  private apiUrl = `${MyConfig.address}/api/UserAccount`;

  constructor(http: HttpClient) {
    super(http, 'UserAccount');
  }

  fromJson(data: any): UserAccount {
    return new UserAccount(data);
  }
}
