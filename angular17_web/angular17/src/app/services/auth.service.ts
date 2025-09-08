import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { DtoLogin, LoginRequest } from '../models/auth.models';
import { catchError } from 'rxjs/operators';
import {environment} from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private http: HttpClient) {}

  login(credentials: LoginRequest): Observable<DtoLogin> {
    return this.http.post<DtoLogin>(`${environment.apiBaseUrl}UserAccount/login`, credentials).pipe(
      catchError((error: HttpErrorResponse) => {
        return throwError(() => error); // Forward error for component to handle
      })
    );
  }

  setToken(token: string) {
    localStorage.setItem('token', token);
  }

  getToken(): string | null {
    return localStorage.getItem('token');
  }

  clearToken() {
    localStorage.removeItem('token');
  }
}
