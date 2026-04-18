import { Component } from '@angular/core';
import { Router } from '@angular/router';


@Component({
  selector: 'app-splash',
  imports: [],
  templateUrl: './splash.html',
  styleUrl: './splash.css',
})
export class Splash {

  constructor(private router: Router) {}


  onEnterClick(): void {
    const time = new Date().toLocaleTimeString();

    console.log('Button clicked at:', time);
    console.log('Navigating to login...');

    this.router.navigate(['/login']);
  }

}


