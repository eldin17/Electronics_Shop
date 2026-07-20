import {Component, Input} from '@angular/core';
import {Notification} from '../../models/notification/notification';

import {TimeAgoPipe} from '../../helpers/time-ago-pipe';

@Component({
  selector: 'app-notif-card',
  imports: [
    TimeAgoPipe
  ],
  templateUrl: './notif-card.html',
  styleUrl: './notif-card.css',
})
export class NotifCard {
  @Input({ required: true }) notif!: Notification;
}
