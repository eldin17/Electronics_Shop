import { Component, Input } from '@angular/core';
import { News } from '../../models/news/news';
import {TimeAgoPipe} from '../../helpers/time-ago-pipe';

@Component({
  selector: 'app-news-card',
  standalone: true,
  imports: [TimeAgoPipe],
  templateUrl: './news-card.html',
  styleUrl: './news-card.css',
})
export class NewsCard {
  @Input({ required: true }) news!: News;
  @Input({ required: true }) image!: string;


}
