import { Routes } from '@angular/router';
import {Splash} from './screens/splash/splash';
import {Login} from './screens/auth/login/login';
import {Register} from './screens/auth/register/register';

export const routes: Routes = [
  { path: '', component: Splash },
  { path: 'login', component: Login },
  { path: 'register', component: Register },
];
