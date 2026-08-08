import { Routes } from '@angular/router';
import { Splash } from './screens/splash/splash';
import { Login } from './screens/auth/login/login';
import { Register } from './screens/auth/register/register';
import { Home } from './screens/home/home';
import { MainLayout } from './screens/main-layout/main-layout';
import {Products} from './screens/products/products';
import {WishlistScreen} from './screens/wishlist/wishlist';
import {ShoppingCart} from './screens/shopping-cart/shopping-cart';
import {InfoDetails} from './screens/info-details/info-details';

export const routes: Routes = [
  { path: '', component: Splash },
  { path: 'login', component: Login },
  { path: 'register', component: Register },

  {
    path: '',
    component: MainLayout,
    children: [
      { path: 'home', component: Home },
      { path: 'products', component: Products },
      { path: 'news', component: InfoDetails, data: { type: 'news' } },
      { path: 'news/:id', component: InfoDetails, data: { type: 'news' } },
      { path: 'wishlist', component: WishlistScreen  },
      { path: 'cart', component: ShoppingCart  },
      { path: 'notification', component: InfoDetails, data: { type: 'notification' } },
      { path: 'notification/:id', component: InfoDetails, data: { type: 'notification' } },
    ]
  },


  { path: '**', redirectTo: '' },
];
