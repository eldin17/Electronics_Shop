import {ChangeDetectorRef, Component, OnDestroy, OnInit} from '@angular/core';

import {ActivatedRoute, RouterLink} from '@angular/router';
import {NotifCard} from '../../components/notif-card/notif-card';
import {Notification} from '../../models/notification/notification';
import {Subscription, switchMap} from 'rxjs';
import {NotificationService} from '../../services/notification.service';
import {AuthService} from '../../services/auth.service';


@Component({
  selector: 'app-notifications',
  imports: [
    NotifCard,
    RouterLink
  ],
  templateUrl: './notifications.html',
  styleUrl: './notifications.css',
})
export class Notifications implements OnInit, OnDestroy {
  notifList: Notification[] = [];
  selectedNotif: Notification | null = null;
  errorMessage = '';
  isLoadingNotifications = true;

  private subs: Subscription[] = [];

  constructor(
    private route: ActivatedRoute,
    private notifService: NotificationService,
    private authService: AuthService,
    private cd: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.subs.push(
      this.notifService.notifications$.subscribe(list => {
        this.notifList = list;
        this.cd.detectChanges();
      })
    );

    const userId = this.authService.getUserId();

    if (userId) {
      this.isLoadingNotifications = true;
      this.notifService.loadForUser(userId).finally(() => {
        this.isLoadingNotifications = false;
        this.cd.detectChanges();
      });
      this.notifService.initSignalR(() => this.authService.getAccessToken());
    } else {
      this.errorMessage = 'Please log in to view notifications.';
      this.isLoadingNotifications = false;
    }

    this.route.paramMap
      .pipe(
        switchMap((params) => {
          const id = params.get('id');
          this.selectedNotif = null;
          this.cd.detectChanges();
          return id ? this.notifService.getByIdNoLoading(parseInt(id)) : [];
        })
      )
      .subscribe((news) => {
        if (news) this.selectedNotif = news as Notification;
        this.cd.detectChanges();
      });
  }

  ngOnDestroy(): void {
    this.subs.forEach(s => s.unsubscribe());
  }
}
