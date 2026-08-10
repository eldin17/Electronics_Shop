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

  private isAuthenticated$ = new BehaviorSubject<boolean>(false);
  readonly authenticated$ = this.isAuthenticated$.asObservable();

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
  getUserRole(): string | null {
    const token = this.getAccessToken();
    if (!token) return null;

    try {
      const payload = JSON.parse(atob(token.split('.')[1]));
      return payload['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] ?? null;
    } catch (e) {
      return null;
    }
  }

  login(payload: any): Observable<LoginResponse> {
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
        shareReplay(1),
        finalize(() => (this.refresh$ = null))
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
    this.isAuthenticated$.next(true);
  }

  clearAccessToken() {
    this.accessToken = null;
    this.isAuthenticated$.next(false);
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
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      'accept': 'text/plain'
    });

    return this.http
      .post<any>(this.apiUrl + '/register', payload, {
        headers,
        withCredentials: true
      });
  }
}
