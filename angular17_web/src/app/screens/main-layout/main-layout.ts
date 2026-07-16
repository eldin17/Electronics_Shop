import {Component, OnInit, OnDestroy, ViewChild, HostListener, ElementRef, ChangeDetectorRef} from '@angular/core';
import { Router, RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';
import { Subscription } from 'rxjs';
import { SearchBar } from '../../components/search-bar/search-bar';
import { AuthService } from '../../services/auth.service';
import { NotificationService, NotificationPopup } from '../../services/notification.service';
import { Notification } from '../../models/notification/notification';
import {TimeAgoPipe} from '../../helpers/time-ago-pipe';


@Component({
  selector: 'app-main-layout',
  standalone: true,
  imports: [RouterOutlet, RouterLink, RouterLinkActive, SearchBar, TimeAgoPipe],
  templateUrl: './main-layout.html',
  styleUrl: './main-layout.css'
})
export class MainLayout implements OnInit, OnDestroy {
  @ViewChild('profileWrapper') profileWrapper!: ElementRef;
  @ViewChild('notifWrapper') notifWrapper!: ElementRef;

  isProfileMenuOpen = false;
  isNotifMenuOpen = false;

  notificationsList: Notification[] = [];
  newNotificationCount = 0;
  isLoadingNotifications = true;
  private isBadgeDismissed = false;

  showToast = false;
  toastTitle = '';
  toastContent = '';
  private toastTimeoutId?: ReturnType<typeof setTimeout>;

  private subs: Subscription[] = [];

  constructor(
    private authService: AuthService,
    private notificationService: NotificationService,
    private router: Router,
    private elementRef: ElementRef,
    private cd: ChangeDetectorRef
  ) {}



  ngOnInit(): void {
    this.subs.push(
      this.notificationService.notifications$.subscribe(list => {
        this.notificationsList = list;
        if(!this.isBadgeDismissed) {
          this.newNotificationCount = list.length;
        }
      })
    );

    this.subs.push(
      this.notificationService.newNotificationCount$.subscribe(count => {
        console.log('Badge count updated:', count);
        if (!this.isBadgeDismissed) {
          this.newNotificationCount = count;
        }
      })
    );

    this.subs.push(
      this.notificationService.popup$.subscribe(popup => {
        this.isBadgeDismissed = false;
        this.showPopup(popup);
      })
    );

    const userId = this.authService.getUserId();

    if (userId) {
      this.isLoadingNotifications = true;
      this.notificationService.loadForUser(userId).finally(() => {
        this.isLoadingNotifications = false;
      });
      this.notificationService.initSignalR(() => this.authService.getAccessToken());
    } else {
      this.isLoadingNotifications = false;
    }
  }

  ngOnDestroy(): void {
    this.subs.forEach(s => s.unsubscribe());
    if (this.toastTimeoutId) clearTimeout(this.toastTimeoutId);
  }

  goToNotifications(): void {
    //this.router.navigate(['/notifications']);
  }

  goToProfile(): void {
    //this.router.navigate(['/profile']);
  }

  logout() {
    this.authService.logout().subscribe({
      next: () => {
        this.notificationService.stopSignalR();
        this.router.navigate(['/login']);
      },
      error: () => {
        this.authService.clearAccessToken();
        this.notificationService.stopSignalR();
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
    this.isNotifMenuOpen = false;
  }


  async onBellClick(): Promise<void> {
    const wasOpen = this.isNotifMenuOpen;
    this.isProfileMenuOpen = false;

    if (wasOpen) {
      this.isNotifMenuOpen = false;
      return;
    }

    this.isNotifMenuOpen = true;

    this.newNotificationCount = 0;
    this.isBadgeDismissed = true;

    const userId = this.authService.getUserId?.();
    if (userId) {
      this.isLoadingNotifications = true;
      this.cd.detectChanges();
      this.notificationService.refreshForUser(userId)
        .catch(err => console.error('Failed to refresh notifications:', err))
        .finally(() => {
          this.isLoadingNotifications = false;
          this.cd.detectChanges();
        });
    }
  }

  onProfileOption(option: string): void {
    console.log('Selected:', option);
    this.isProfileMenuOpen = false;
  }

  onNotificationClick(notification: Notification): void {
    const userId = this.authService.getUserId();
    if (!userId) return;

    this.notificationService.markAsRead(userId, notification.id).catch(err =>
      console.error('Failed to mark notification as read:', err)
    );
  }

  get notificationCount(): number {
    return this.newNotificationCount;
  }

  private showPopup(popup: NotificationPopup): void {
    this.toastTitle = popup.title;
    this.toastContent = popup.content;
    this.showToast = true;
    this.cd.detectChanges();
    if (this.toastTimeoutId) clearTimeout(this.toastTimeoutId);
    this.toastTimeoutId = setTimeout(() => {
      this.showToast = false;
    }, 2500);
  }
}
