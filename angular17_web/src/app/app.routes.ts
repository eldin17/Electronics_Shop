import { Routes } from '@angular/router';
import { Splash } from './screens/splash/splash';
import { Login } from './screens/auth/login/login';
import { Register } from './screens/auth/register/register';
import { Home } from './screens/home/home';
import { MainLayout } from './screens/main-layout/main-layout';
import {Products} from './screens/products/products';
import {NewsScreen} from './screens/news/news';
import {WishlistScreen} from './screens/wishlist/wishlist';
import {ShoppingCart} from './screens/shopping-cart/shopping-cart';

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
      { path: 'news', component: NewsScreen },
      { path: 'news/:id', component: NewsScreen },
      { path: 'wishlist', component: WishlistScreen  },
      { path: 'cart', component: ShoppingCart  },

    ]
  },


  { path: '**', redirectTo: '' },
];
