import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {BehaviorSubject, Observable, tap} from 'rxjs';
import {MyConfig} from '../my-config';
import {LoginResponse} from '../models/login-response';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private apiUrl = `${MyConfig.address}/api/UserAccount`;

  private accessToken: string | null = null;

  private isAuthenticated$ = new BehaviorSubject<boolean>(false);
  readonly authenticated$ = this.isAuthenticated$.asObservable();

  constructor(private http: HttpClient) {}

  login(payload: any): Observable<any> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      'accept': 'text/plain'
    });

    return this.http
      .post<LoginResponse>(this.apiUrl + '/login', payload, {
        headers,
        withCredentials: true
      })
      .pipe(
        tap((res) => {
          this.setAccessToken(res.accessToken);
        })
      );
  }

  refresh(): Observable<LoginResponse> {
    return this.http
      .post<LoginResponse>(this.apiUrl + '/refresh', {}, { withCredentials: true })
      .pipe(tap((res) => this.setAccessToken(res.accessToken)));
  }

  logout(): Observable<any> {
    return this.http.post(this.apiUrl + '/logout', {}, { withCredentials: true }).pipe(
      tap(() => this.clearAccessToken())
    );
  }

  setAccessToken(token: string) {
    this.accessToken = token;
    this.isAuthenticated$.next(true);
  }

  clearAccessToken() {
    this.accessToken = null;
    this.isAuthenticated$.next(false);
  }

  getAccessToken(): string | null {
    return this.accessToken;
  }
}
