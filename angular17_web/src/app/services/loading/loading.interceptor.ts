import {HttpContext, HttpContextToken, HttpInterceptorFn} from '@angular/common/http';
import { inject } from '@angular/core';

import { LoadingService } from './loading.service';
import {finalize} from 'rxjs';

export const BYPASS_LOADING = new HttpContextToken<boolean>(() => false);

export const loadingInterceptor: HttpInterceptorFn = (req, next) => {
  const loadingService = inject(LoadingService);

  if (req.context.get(BYPASS_LOADING)) {
    return next(req);
  }

  loadingService.show();

  return next(req).pipe(
    finalize(() => loadingService.hide())
  );
};
