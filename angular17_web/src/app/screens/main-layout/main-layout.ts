import { Component } from '@angular/core';
import { Router, RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { SearchBar } from '../../components/search-bar/search-bar';

@Component({
  selector: 'app-main-layout',
  standalone: true,
  imports: [RouterOutlet, RouterLink, RouterLinkActive, SearchBar],
  templateUrl: './main-layout.html',
  styleUrl: './main-layout.css'
})

export class MainLayout {
  constructor(private router: Router) {}

  goToNotifications(): void {
    //this.router.navigate(['/notifications']);
  }

  goToProfile(): void {
    //this.router.navigate(['/profile']);
  }

  goToCart(): void {
    //this.router.navigate(['/cart']);
  }
}
