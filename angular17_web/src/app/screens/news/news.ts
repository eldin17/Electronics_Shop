import {ChangeDetectorRef, Component, OnInit} from '@angular/core';
import {NewsCard} from '../../components/news-card/news-card';
import {ProductCard} from '../../components/product-card/product-card';
import {ActivatedRoute, RouterLink} from '@angular/router';
import {News} from '../../models/news/news';
import {NewsService} from '../../services/news.service';
import {switchMap} from 'rxjs';

@Component({
  selector: 'app-news',
  imports: [
    NewsCard,
    ProductCard,
    RouterLink
  ],
  templateUrl: './news.html',
  styleUrl: './news.css',
})
export class NewsScreen implements OnInit {
  newsList: News[] = [];
  selectedNews: News | null = null;
  errorMessage = '';

  constructor(
    private route: ActivatedRoute,
    private newsService: NewsService,
    private cd: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.newsService.getAll().subscribe({
      next: (list) => (this.newsList = list.data),
      error: () => (this.errorMessage = 'Could not load news.')
    });

    this.route.paramMap
      .pipe(
        switchMap((params) => {
          const id = params.get('id');
          this.selectedNews = null;
          this.cd.detectChanges();
          return id ? this.newsService.getByIdNoLoading(parseInt(id)) : [];
        })
      )
      .subscribe((news) => {
        if (news) this.selectedNews = news as News;
        this.cd.detectChanges();
      });
  }
}
