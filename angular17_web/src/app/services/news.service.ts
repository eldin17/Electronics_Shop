import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {firstValueFrom, Observable} from 'rxjs';

import {Pagination} from '../models/pagination';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';

import {News} from '../models/news/news';
import {SearchNews} from '../models/news/search.news';
import {AddNews} from '../models/news/add.news';
import {UpdateNews} from '../models/news/update.news';
import {BYPASS_LOADING} from './loading/loading.interceptor';


@Injectable({ providedIn: 'root' })
export class NewsService extends BaseCRUDProvider<News, SearchNews, AddNews, UpdateNews> {
  private apiUrl = `${MyConfig.address}/api/News`;

  constructor(http: HttpClient) {
    super(http, 'News');
  }

  fromJson(data: any): News {
    return new News(data);
  }

  getByIdNoLoading(id: number): Promise<News> {
    return firstValueFrom(
      this.http.get<any>(`${this.baseUrl}${this.endpoint}/${id}`, {
        context: new HttpContext().set(BYPASS_LOADING, true)
      })
    ).then(data => this.fromJson(data));
  }
}
