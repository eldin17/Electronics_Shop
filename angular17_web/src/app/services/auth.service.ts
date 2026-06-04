import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {Observable} from 'rxjs';
import {MyConfig} from '../my-config';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private apiUrl = `${MyConfig.address}/api/UserAccount`;

  constructor(private http: HttpClient) {}

  login(payload: any): Observable<any> {
    const headers = new HttpHeaders({
      'Content-Type': 'application/json',
      'accept': 'text/plain'
    });

    return this.http.post(this.apiUrl+'/login', payload, { headers });
  }
}
