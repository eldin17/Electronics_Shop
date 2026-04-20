import { Component } from '@angular/core';
import {RouterLink} from '@angular/router';
import {FormsModule, NgForm} from '@angular/forms';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-login',
  imports: [RouterLink, FormsModule],
  templateUrl: './login.html',
  styleUrl: './login.css',
})
export class Login {

  constructor(private http: HttpClient) {}

  onLoginSubmit(form: NgForm) {

    if (form.invalid) {
      Object.values(form.controls).forEach(control => control.markAsTouched());
      return;
    }

    const payload = {
      username: form.value.username,
      password: form.value.password
    };

    this.http.post('http://localhost:5116/api/UserAccount/login', payload, {
      headers: {
        'Content-Type': 'application/json',
        'accept': 'text/plain'
      }
    }).subscribe({
      next: (response) => {
        console.log('Login success:', response);
      },
      error: (err) => {
        console.error('Login failed:', err);
      }
    });
  }
}
