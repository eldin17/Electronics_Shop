import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import {SearchProduct} from '../models/product/search.product';
import {Pagination} from '../models/pagination';
import {Product} from '../models/product/product';
import {MyConfig} from '../my-config';
import {BaseCRUDProvider} from './base.CRUD.provider';
import {UpdateProduct} from '../models/product/update.product';
import {AddProduct} from '../models/product/add.product';


@Injectable({ providedIn: 'root' })
export class ProductService extends BaseCRUDProvider<Product, SearchProduct, AddProduct, UpdateProduct> {
  private apiUrl = `${MyConfig.address}/api/Product`;

  constructor(http: HttpClient) {
    super(http, 'Product');
  }

  fromJson(data: any): Product {
    return new Product(data);
  }

  getAllWithChecks(customerId: number, search?: SearchProduct): Observable<Pagination<Product>> {
    return this.http.get<Pagination<Product>>(
      `${this.baseUrl}${this.endpoint}/GetAllWithChecks/${customerId}`,
      { params: this.getQueryParams(search) }
    );
  }

  getAllWithChecksByUserAccId(userAccId: number, search?: SearchProduct): Observable<Pagination<Product>> {
    return this.http.get<Pagination<Product>>(
      `${this.baseUrl}${this.endpoint}/GetAllWithChecksByUserAccId/${userAccId}`,
      { params: this.getQueryParams(search) }
    );
  }
}
