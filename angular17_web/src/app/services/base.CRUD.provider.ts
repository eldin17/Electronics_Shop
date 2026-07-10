import {BaseProvider} from "./base.provider";
import {Observable} from "rxjs";

export abstract class BaseCRUDProvider<T, TSearch = any, TAdd = any, TUpdate = any> extends BaseProvider<T, TSearch> {

  add(obj: TAdd): Observable<T> {
    return this.http.post<T>(`${this.baseUrl}${this.endpoint}`, obj);
  }

  update(id: number, obj: TUpdate): Observable<T> {
    return this.http.put<T>(`${this.baseUrl}${this.endpoint}/${id}`, obj);
  }

  delete(id: number): Observable<T> {
    return this.http.delete<T>(`${this.baseUrl}${this.endpoint}/${id}`);
  }
}
