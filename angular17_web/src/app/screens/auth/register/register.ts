import { Component } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { FormsModule, NgForm } from '@angular/forms';
import { AuthService } from '../../../services/auth.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ImageService } from '../../../services/image.service';

import { firstValueFrom } from 'rxjs';
import {ImageUpload} from '../../../components/image-upload/image-upload';

@Component({
  selector: 'app-register',
  imports: [
    FormsModule, RouterLink, ImageUpload
  ],
  templateUrl: './register.html',
  styleUrl: './register.css',
})
export class Register {

  constructor(private authService: AuthService,
              private imageService: ImageService,
              private router: Router,
              private snackBar: MatSnackBar
  ) {}

  selectedFile: File | null = null;

  onImageSelected(file: File): void {
    this.selectedFile = file;
  }

  async onRegisterSubmit(form: NgForm) {
    if (form.invalid) {
      Object.values(form.controls).forEach(control => control.markAsTouched());
      return;
    }

    if (form.value.password !== form.value.confirmPassword) {
      return;
    }

    const payload = {
      email: form.value.email,
      username: form.value.username,
      password: form.value.password,
      roleId: 1,
      imageId: this.selectedFile ? 0 : 1
    };

    try {
      const newUser = await firstValueFrom(this.authService.register(payload));

      if (this.selectedFile) {
        await firstValueFrom(this.imageService.uploadUserImage(newUser.id, this.selectedFile));
      }

      this.snackBar.open('🎉 Account created! Let the adventure begin 🌟', 'Close', {
        duration: 4000,
        horizontalPosition: 'end',
        verticalPosition: 'top'
      });

      setTimeout(() => this.router.navigate(['/login']), 1500);
    } catch (err) {
      console.error('Registration failed:', err);
      this.snackBar.open('❌ Oops! Something went wrong. Please try again.', 'Close', {
        duration: 4000,
        panelClass: ['custom-error-snackbar'],
        horizontalPosition: 'end',
        verticalPosition: 'top'
      });
    }
  }
}
