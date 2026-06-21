import { Component } from '@angular/core';
import { Router } from '@angular/router';
import {AuthService} from '../../services/auth.service';


@Component({
  selector: 'app-splash',
  imports: [],
  templateUrl: './splash.html',
  styleUrl: './splash.css',
})
export class Splash {

  constructor(private router: Router, private authService: AuthService) {}


  onEnterClick(): void {
    const time = new Date().toLocaleTimeString();

    console.log('Button clicked at:', time);

    if (this.authService.getAccessToken()) {
      console.log('Valid session found, navigating to home...');
      this.router.navigate(['/home']);
    } else {
      console.log('No valid session, navigating to login...');
      this.router.navigate(['/login']);
    }

  }

}


