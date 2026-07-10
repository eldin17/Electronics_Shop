import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import {MyConfig} from "../my-config";
import {Pagination} from "../models/pagination";

export abstract class BaseProvider<T, TSearch = any> {
  protected baseUrl: string = MyConfig.address+'/api/';
  protected endpoint: string = '';

  constructor(protected http: HttpClient, endpoint: string) {
    this.endpoint = endpoint;
  }

  abstract fromJson(data: any): T;

  protected getQueryParams(filter?: TSearch): HttpParams {
    let params = new HttpParams();
    if (filter) {
      Object.keys(filter).forEach((key) => {
        const value = (filter as any)[key];
        if (value !== null && value !== undefined) {
          params = params.set(key, value.toString());
        }
      });
    }
    return params;
  }

  getAll(filter?: TSearch): Observable<Pagination<T>> {
    return this.http.get<Pagination<T>>(`${this.baseUrl}${this.endpoint}`, {
      params: this.getQueryParams(filter),
    });
  }

  getById(id: number): Observable<T> {
    return this.http.get<T>(`${this.baseUrl}${this.endpoint}/${id}`);
  }
}
