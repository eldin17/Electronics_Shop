import { Routes } from '@angular/router';
import { Splash } from './screens/splash/splash';
import { Login } from './screens/auth/login/login';
import { Register } from './screens/auth/register/register';
import { Home } from './screens/home/home';
import { MainLayout } from './screens/main-layout/main-layout';

export const routes: Routes = [
  { path: '', component: Splash },
  { path: 'login', component: Login },
  { path: 'register', component: Register },

  {
    path: '',
    component: MainLayout,
    children: [
      { path: 'home', component: Home },

    ]
  },

  { path: '**', component: Splash },
];
