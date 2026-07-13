import {Component, inject, signal} from '@angular/core';
import { RouterOutlet } from '@angular/router';
import {Splash} from './screens/splash/splash';
import {LoadingService} from './services/loading/loading.service';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, Splash],
  templateUrl: './app.html',
  styleUrl: './app.css',
})
export class App {
  protected readonly title = signal('electronics-shop');
  loadingService = inject(LoadingService);
}
