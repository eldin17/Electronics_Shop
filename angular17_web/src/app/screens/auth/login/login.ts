import { Component } from '@angular/core';
import {Router, RouterLink} from '@angular/router';
import {FormsModule, NgForm} from '@angular/forms';
import {AuthService} from '../../../services/auth.service';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';

@Component({
  selector: 'app-login',
  imports: [MatSnackBarModule, RouterLink, FormsModule],
  templateUrl: './login.html',
  styleUrl: './login.css',
})
export class Login {
  rememberMe = false;

  constructor(private authService: AuthService,
              private router: Router,
              private snackBar: MatSnackBar) {}

  onLoginSubmit(form: NgForm) {
    if (form.invalid) {
      Object.values(form.controls).forEach(control => control.markAsTouched());
      return;
    }

    const payload = {
      username: form.value.username,
      password: form.value.password,
      rememberMe: this.rememberMe
    };

    this.authService.login(payload).subscribe({
      next: (response) => {
        console.log('Login success:', response);


        console.log('Navigating to home screen...');

        this.router.navigate(['/home']);
      },
      error: (err) => {
        console.error('Login failed:', err);

        this.snackBar.open('Invalid username or password.', 'Close', {
          duration: 4000,
          panelClass: ['custom-error-snackbar'],
          horizontalPosition: 'end',
          verticalPosition: 'top'
        });
      }
    });
  }
}
