import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {BehaviorSubject, finalize, Observable, shareReplay, tap} from 'rxjs';
import {MyConfig} from '../my-config';
import {LoginResponse} from '../models/login-response';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private apiUrl = `${MyConfig.address}/api/UserAccount`;

  private accessToken: string | null = null;

  private setupCompleted: boolean | null = null;

  constructor(private http: HttpClient) {}

  getUserId(): number | null {
    const token = this.getAccessToken();
    if (!token) return null;

    try {
      const payload = JSON.parse(atob(token.split('.')[1]));
      return payload.sub ? Number(payload.sub) : null;
    } catch (e) {
      console.error('Failed to decode token', e);
      return null;
    }
  }

  login(payload: any): Observable<LoginResponse> {

    return this.http
      .post<LoginResponse>(this.apiUrl + '/login', payload, {
        withCredentials: true
      })
      .pipe(
        tap((res) => {
          this.setAccessToken(res.accessToken);
          this.setSetupCompleted(res.setupCompleted);
        })
      );
  }

  private refresh$: Observable<LoginResponse> | null = null;

  refresh(): Observable<LoginResponse> {
    if (this.refresh$) {
      return this.refresh$;
    }

    this.refresh$ = this.http
      .post<LoginResponse>(this.apiUrl + '/refresh', {}, { withCredentials: true })
      .pipe(
        tap((res) => {
          this.setAccessToken(res.accessToken);
          this.setSetupCompleted(res.setupCompleted);
        }),
        finalize(() => (this.refresh$ = null)),
        shareReplay(1)
      );

    return this.refresh$;
  }

  logout(): Observable<any> {
    return this.http.post(this.apiUrl + '/logout', {}, { withCredentials: true }).pipe(
      tap(() => {
        this.clearAccessToken();
        this.setupCompleted = null;
      })
    );
  }

  setAccessToken(token: string) {
    this.accessToken = token;
  }

  clearAccessToken() {
    this.accessToken = null;
  }

  getAccessToken(): string | null {
    return this.accessToken;
  }

  setSetupCompleted(value: boolean | null) {
    this.setupCompleted = value;
  }

  isProfileComplete(): boolean {
    return this.setupCompleted === true;
  }

  register(payload: any): Observable<any> {
    return this.http
      .post<any>(this.apiUrl + '/register', payload, {
        withCredentials: true
      });
  }
}
