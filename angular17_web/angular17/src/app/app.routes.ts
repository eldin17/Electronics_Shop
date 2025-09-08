import { Routes } from '@angular/router';
import {LoginComponent} from './screens/login/login.component';

export const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' }, // default route
  { path: 'login', component: LoginComponent },
];
