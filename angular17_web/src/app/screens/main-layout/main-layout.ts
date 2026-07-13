import {Component, ViewChild} from '@angular/core';
import { Router, RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { SearchBar } from '../../components/search-bar/search-bar';
import {AuthService} from '../../services/auth.service';
import { HostListener, ElementRef } from '@angular/core';

@Component({
  selector: 'app-main-layout',
  standalone: true,
  imports: [RouterOutlet, RouterLink, RouterLinkActive, SearchBar,],
  templateUrl: './main-layout.html',
  styleUrl: './main-layout.css'
})

export class MainLayout {
  @ViewChild('profileWrapper') profileWrapper!: ElementRef;
  @ViewChild('notifWrapper') notifWrapper!: ElementRef;

  isProfileMenuOpen = false;
  isNotifMenuOpen = false;

  constructor(
    private authService: AuthService,
    private router: Router,
    private elementRef: ElementRef
  ) {}

  goToNotifications(): void {
    //this.router.navigate(['/notifications']);
  }

  goToProfile(): void {
    //this.router.navigate(['/profile']);
  }

  goToCart(): void {
    //this.router.navigate(['/cart']);
  }

  logout() {
    this.authService.logout().subscribe({
      next: () => this.router.navigate(['/login']),
      error: () => {
        this.authService.clearAccessToken();
        this.router.navigate(['/login']);
      }
    });
  }

  @HostListener('document:click', ['$event'])
  onDocumentClick(event: MouseEvent): void {
    if (this.isProfileMenuOpen &&
      this.profileWrapper &&
      !this.profileWrapper.nativeElement.contains(event.target)) {
      this.isProfileMenuOpen = false;
    }
    if (this.isNotifMenuOpen &&
      this.notifWrapper &&
      !this.notifWrapper.nativeElement.contains(event.target)) {
      this.isNotifMenuOpen = false;
    }
  }

  toggleProfileMenu(): void {
    this.isProfileMenuOpen = !this.isProfileMenuOpen;
    this.isNotifMenuOpen = false; // close the other one when opening this
  }

  toggleNotifMenu(): void {
    this.isNotifMenuOpen = !this.isNotifMenuOpen;
    this.isProfileMenuOpen = false; // close the other one when opening this
  }

  onProfileOption(option: string): void {
    console.log('Selected:', option);
    this.isProfileMenuOpen = false;
  }
}
