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
    console.log('Splash Skip Button clicked at:', time);

    this.router.navigate(['/home']);
  }


}

