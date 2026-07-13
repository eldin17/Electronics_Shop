import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

import {Pagination} from '../models/pagination';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';

import {News} from '../models/news/news';
import {SearchNews} from '../models/news/search.news';
import {AddNews} from '../models/news/add.news';
import {UpdateNews} from '../models/news/update.news';


@Injectable({ providedIn: 'root' })
export class NewsService extends BaseCRUDProvider<News, SearchNews, AddNews, UpdateNews> {
  private apiUrl = `${MyConfig.address}/api/News`;

  constructor(http: HttpClient) {
    super(http, 'News');
  }

  fromJson(data: any): News {
    return new News(data);
  }
}
