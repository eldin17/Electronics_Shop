import { Injectable } from '@angular/core';
import {HttpClient, HttpContext, HttpParams} from '@angular/common/http';
import {firstValueFrom, Observable} from 'rxjs';

import {Pagination} from '../models/pagination';

import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';


import {BYPASS_LOADING} from './loading/loading.interceptor';
import {Review} from '../models/review/review';
import {SearchReview} from '../models/review/search.review';
import {AddReview} from '../models/review/add.review';
import {UpdateReview} from '../models/review/update.review';





@Injectable({ providedIn: 'root' })
export class ReviewService extends BaseCRUDProvider<Review, SearchReview, AddReview, UpdateReview> {
  private apiUrl = `${MyConfig.address}/api/Review`;

  constructor(http: HttpClient) {
    super(http, 'Review');
  }

  fromJson(data: any): Review {
    return new Review(data);
  }
}
