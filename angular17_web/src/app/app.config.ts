import {ApplicationConfig, inject, provideAppInitializer, provideBrowserGlobalErrorListeners} from '@angular/core';
import { provideRouter } from '@angular/router';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async'; // Look for this
import { routes } from './app.routes';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import {authInterceptor} from './helpers/auth-interceptor';
import {AuthService} from './services/auth.service';
import {catchError, firstValueFrom, of} from 'rxjs';


export const appConfig: ApplicationConfig = {
  providers: [
    provideHttpClient(withInterceptors([authInterceptor])),
    provideAppInitializer(() => {
      const authService = inject(AuthService);
      return firstValueFrom(
        authService.refresh().pipe(catchError(() => of(null)))
      );
    }),
    provideBrowserGlobalErrorListeners(),
    provideRouter(routes),
    provideAnimationsAsync()
  ],
};
