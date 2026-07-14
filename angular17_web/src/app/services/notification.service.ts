import { Injectable, NgZone } from '@angular/core';
import * as signalR from '@microsoft/signalr';
import { BehaviorSubject, Observable, Subject, firstValueFrom } from 'rxjs';
import {HttpClient, HttpContext} from '@angular/common/http';

import { BaseCRUDProvider } from './base.CRUD.provider';
import { SearchNotification } from '../models/notification/search.notification';
import { AddNotification } from '../models/notification/add.notification';
import { UpdateNotification } from '../models/notification/update.notification';
import { Notification } from '../models/notification/notification';
import { Pagination } from '../models/pagination';
import { MyConfig } from '../my-config';
import {BYPASS_LOADING} from './loading/loading.interceptor';

export interface NotificationPopup {
  title: string;
  content: string;
}

@Injectable({
  providedIn: 'root'
})
export class NotificationService extends BaseCRUDProvider<Notification, SearchNotification, AddNotification, UpdateNotification> {

  constructor(http: HttpClient, private ngZone: NgZone) {
    super(http, 'Notification');
  }

  fromJson(data: any): Notification {
    return new Notification(data);
  }

  private hubConnection?: signalR.HubConnection;
  private isConnected = false;


  private newNotificationCountSubject = new BehaviorSubject<number>(0);
  newNotificationCount$: Observable<number> = this.newNotificationCountSubject.asObservable();
  get newNotificationCount(): number {
    return this.newNotificationCountSubject.value;
  }

  private notificationsSubject = new BehaviorSubject<Notification[]>([]);
  notifications$: Observable<Notification[]> = this.notificationsSubject.asObservable();


  private popupSubject = new Subject<NotificationPopup>();
  popup$: Observable<NotificationPopup> = this.popupSubject.asObservable();



  getAllForUser(userAccountId: number, filter?: SearchNotification): Promise<Pagination<Notification>> {
    const params = this.getQueryParams(filter);

    return firstValueFrom(
      this.http.get<Pagination<Notification>>(
        `${this.baseUrl}${this.endpoint}/GetAllForUser/${userAccountId}`,
        {
          params,
          context: new HttpContext().set(BYPASS_LOADING, true)
        }
      )
    );
  }

  addForUser(payload: AddNotification): Promise<Notification> {
    return firstValueFrom(
      this.http.post<Notification>(`${this.baseUrl}${this.endpoint}/AddForUser`, payload)
    );
  }

  markAsRead(userAccId: number, notificationId: number): Promise<string> {
    return firstValueFrom(
      this.http.post<string>(
        `${this.baseUrl}${this.endpoint}/MarkAsRead/${userAccId}/${notificationId}`,
        {}
      )
    );
  }

  clearNotificationFlag(): void {
    this.newNotificationCountSubject.next(0);
  }



  async loadForUser(userAccountId: number): Promise<void> {
    const result = await this.getAllForUser(userAccountId);
    this.notificationsSubject.next(result.data);
  }

  async refreshForUser(userAccountId: number): Promise<void> {
    this.clearNotificationFlag();
    const result = await this.getAllForUser(userAccountId);
    this.notificationsSubject.next(result.data);
  }


  initSignalR(getToken: () => string | null | undefined): void {
    if (this.isConnected) {
      console.log('SignalR: Already connected, aborting.');
      return;
    }

    this.hubConnection = new signalR.HubConnectionBuilder()
      .withUrl(`${MyConfig.address}/notificationHub`, {
        accessTokenFactory: () => getToken() ?? ''
      })
      .withAutomaticReconnect()
      .build();

    this.hubConnection.on('ReceiveNotification', (data: any) => {

      this.ngZone.run(() => {
        this.newNotificationCountSubject.next(this.newNotificationCountSubject.value + 1);
        this.popupSubject.next({
          title: data?.title ?? 'New Notification',
          content: data?.content ?? ''
        });
        console.log('--- SIGNALR NOTIFICATION RECEIVED ---');
      });
    });

    this.hubConnection
      .start()
      .then(() => {
        this.isConnected = true;
        console.log('SignalR: Connected to Hub successfully.');
      })
      .catch(err => console.error('SignalR Error:', err));
  }

  stopSignalR(): void {
    this.hubConnection?.stop();
    this.isConnected = false;
  }
}
