import { Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import {Splash} from './screens/splash/splash';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, Splash],
  templateUrl: './app.html',
  styleUrl: './app.css',
})
export class App {
  protected readonly title = signal('electronics-shop');
}
