import { Component, ElementRef, EventEmitter, HostListener, Output, ViewChild } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-profile-dropdown',
  imports: [],
  templateUrl: './profile-dropdown.html',
  styleUrl: './profile-dropdown.css',
})
export class ProfileDropdown {
  @ViewChild('wrapper') private wrapper!: ElementRef;

  @Output() opened = new EventEmitter<void>();
  @Output() logoutClicked = new EventEmitter<void>();

  isOpen = false;

  constructor(private router: Router) {}

  toggle(): void {
    this.isOpen = !this.isOpen;
    if (this.isOpen) {
      this.opened.emit();
    }
  }

  close(): void {
    this.isOpen = false;
  }

  onOption(option: string): void {
    this.close();

    switch (option) {
      case 'Personal Info':
        this.router.navigate(['/profile-edit']);
        break;
      case 'Orders':
        this.router.navigate(['/orders']);
        break;
      default:
        console.log('Selected:', option);
    }
  }

  onLogout(): void {
    this.close();
    this.logoutClicked.emit();
  }

  @HostListener('document:click', ['$event'])
  onDocumentClick(event: MouseEvent): void {
    if (this.isOpen && this.wrapper && !this.wrapper.nativeElement.contains(event.target)) {
      this.close();
    }
  }
}
