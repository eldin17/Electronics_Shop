import { HttpInterceptorFn, HttpErrorResponse } from '@angular/common/http';
import { inject } from '@angular/core';
import { catchError, switchMap, throwError } from 'rxjs';
import {AuthService} from '../services/auth.service';
import {Router} from '@angular/router';

export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const authService = inject(AuthService);
  const token = authService.getAccessToken();
  const router = inject(Router);

  const authReq = token
    ? req.clone({ setHeaders: { Authorization: `Bearer ${token}` } })
    : req;

  return next(authReq).pipe(
    catchError((err: HttpErrorResponse) => {
      if (err.status !== 401 || req.url.includes('/refresh')) {
        return throwError(() => err);
      }

      return authService.refresh().pipe(
        switchMap((res) =>
          next(req.clone({ setHeaders: { Authorization: `Bearer ${res.accessToken}` } }))
        ),
        catchError((refreshErr) => {

          authService.clearAccessToken();
          router.navigate(['/login']);

          return throwError(() => refreshErr);
        })
      );
    })
  );
};
