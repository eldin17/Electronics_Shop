import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { catchError, map, of } from 'rxjs';
import { AuthService } from '../services/auth.service';


export const authGuard: CanActivateFn = () => {
  const authService = inject(AuthService);
  const router = inject(Router);


  if (!authService.getAccessToken()) {
    return authService.refresh().pipe(
      map(() =>
        authService.isProfileComplete() ? true : router.parseUrl('/finish-set-up')
      ),
      catchError(() => of(router.parseUrl('/login')))
    );
  }

  if (!authService.isProfileComplete()) {
    return router.parseUrl('/finish-set-up');
  }
  return true;
};


export const finishSetUpGuard: CanActivateFn = () => {
  const authService = inject(AuthService);
  const router = inject(Router);

  if (!authService.getAccessToken()) {
    return authService.refresh().pipe(
      map(() =>
        authService.isProfileComplete() ? router.parseUrl('/home') : true
      ),
      catchError(() => of(router.parseUrl('/login')))
    );
  }

  if (authService.isProfileComplete()) {
    return router.parseUrl('/home');
  }
  return true;
};


export const guestGuard: CanActivateFn = () => {
  const authService = inject(AuthService);
  const router = inject(Router);

  if (!authService.getAccessToken()) {
    return authService.refresh().pipe(
      map(() =>
        router.parseUrl(authService.isProfileComplete() ? '/home' : '/finish-set-up')
      ),
      catchError(() => of(true))
    );
  }

  return router.parseUrl(authService.isProfileComplete() ? '/home' : '/finish-set-up');
};
