import { Routes } from '@angular/router';
import {Splash} from './screens/splash/splash';
import {Login} from './screens/auth/login/login';
import {Register} from './screens/auth/register/register';
import {Home} from './screens/home/home';

export const routes: Routes = [
  { path: '', component: Splash },
  { path: 'login', component: Login },
  { path: 'register', component: Register },
  { path: 'home', component: Home },
  { path: '**', component: Splash },
];
