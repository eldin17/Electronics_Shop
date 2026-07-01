import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import {BehaviorSubject, Observable, tap} from 'rxjs';
import {MyConfig} from '../my-config';


@Injectable({ providedIn: 'root' })
export class ImageService {
  private apiUrl = `${MyConfig.address}/api/Image`;

  constructor(private http: HttpClient) {}

  uploadUserImage(userId: number, file: File): Observable<any> {
    const formData = new FormData();
    formData.append('vmImage', file, file.name);

    return this.http.post<any>(
      `${this.apiUrl}/UserAccount/${userId}/image`,
      formData,
      { withCredentials: true }
    );
  }
}
