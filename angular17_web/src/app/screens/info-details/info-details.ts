import {ChangeDetectorRef, Component, OnDestroy, OnInit} from '@angular/core';
import {CommonModule} from '@angular/common';
import {ActivatedRoute, RouterLink} from '@angular/router';
import {Subscription, switchMap} from 'rxjs';

import {NewsCard} from '../../components/news-card/news-card';
import {NotifCard} from '../../components/notif-card/notif-card';
import {News} from '../../models/news/news';
import {Notification} from '../../models/notification/notification';
import {NewsService} from '../../services/news.service';
import {NotificationService} from '../../services/notification.service';
import {AuthService} from '../../services/auth.service';

export type InfoType = 'news' | 'notification';
type InfoItem = News | Notification;

@Component({
  selector: 'app-info-details',
  standalone: true,
  imports: [CommonModule, RouterLink, NewsCard, NotifCard],
  templateUrl: './info-details.html',
  styleUrl: './info-details.css',
})
export class InfoDetails implements OnInit, OnDestroy {
  type: InfoType = 'news';

  itemList: InfoItem[] = [];
  selectedItem: InfoItem | null = null;
  errorMessage = '';

  private subs: Subscription[] = [];

  constructor(
    private route: ActivatedRoute,
    private newsService: NewsService,
    private notifService: NotificationService,
    private authService: AuthService,
    private cd: ChangeDetectorRef
  ) {}

  get isNews(): boolean {
    return this.type === 'news';
  }

  get listTitle(): string {
    return this.isNews ? 'News' : 'Notification';
  }

  get emptyListMessage(): string {
    return this.isNews ? 'No news right now.' : 'No notifications right now.';
  }

  get emptySelectionMessage(): string {
    return this.isNews ? 'No news selected' : 'No notification selected';
  }

  get routerLinkBase(): string {
    return this.isNews ? '/news' : '/notification';
  }

  asNews(item: InfoItem): News {
    return item as News;
  }

  asNotif(item: InfoItem): Notification {
    return item as Notification;
  }

  isSelected(item: InfoItem): boolean {
    return this.selectedItem?.id === item.id;
  }

  trackById(_index: number, item: InfoItem): number {
    return item.id;
  }

  ngOnInit(): void {
    this.type = (this.route.snapshot.data['type'] as InfoType) ?? 'news';

    if (this.isNews) {
      this.loadNews();
    } else {
      this.loadNotifications();
    }

    this.route.paramMap
      .pipe(
        switchMap((params) => {
          const id = params.get('id');
          this.selectedItem = null;
          this.cd.detectChanges();
          if (!id) return [];
          return this.isNews
            ? this.newsService.getByIdNoLoading(parseInt(id))
            : this.notifService.getByIdNoLoading(parseInt(id));
        })
      )
      .subscribe((item) => {
        if (item) this.selectedItem = item as InfoItem;
        this.cd.detectChanges();
      });
  }

  private loadNews(): void {
    this.newsService.getAll().subscribe({
      next: (list) => {
        this.itemList = list.data;
        this.cd.detectChanges();
      },
      error: () => {
        this.errorMessage = 'Could not load news.';
        this.cd.detectChanges();
      }
    });
  }

  private loadNotifications(): void {
    this.subs.push(
      this.notifService.notifications$.subscribe((list) => {
        this.itemList = list;
        this.cd.detectChanges();
      })
    );

    const userId = this.authService.getUserId();
    if (userId) {
      this.notifService.loadForUser(userId).finally(() => this.cd.detectChanges());
      this.notifService.initSignalR(() => this.authService.getAccessToken());
    } else {
      this.errorMessage = 'Please log in to view notifications.';
    }
  }

  ngOnDestroy(): void {
    this.subs.forEach((s) => s.unsubscribe());
  }
}
