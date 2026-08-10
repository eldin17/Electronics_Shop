import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { FormsModule, NgForm } from '@angular/forms';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { AuthService } from '../../services/auth.service';
import { CustomerService } from '../../services/customer.service';
import { AddCustomer } from '../../models/customer/add.customer';
import {CountryPicker} from '../../components/country-picker/country-picker';


@Component({
  selector: 'app-finish-set-up',
  imports: [FormsModule, MatSnackBarModule, CountryPicker],
  templateUrl: './finish-set-up.html',
  styleUrl: './finish-set-up.css',
})
export class FinishSetUp {
  constructor(
    private customerService: CustomerService,
    private authService: AuthService,
    private router: Router,
    private snackBar: MatSnackBar
  ) {}

  onConfirm(form: NgForm): void {
    if (form.invalid) {
      Object.values(form.controls).forEach((control) => control.markAsTouched());
      return;
    }

    const { firstName, lastName, dateOfBirth, country, city, street, postalCode } = form.value;


    const payload: AddCustomer = {
      loyaltyPoints: 0,
      userAccountId: this.authService.getUserId()!,
      personId: 0,
      person: {
        firstName,
        lastName,
        dateOfBirth,
      },
      adresses: [
        {
          street,
          city,
          country,
          postalCode,
          personId: 0,
          customerId: 0,
          isDeleted: false,
        },
      ],
      paymentMethods: [],
      isDeleted: false,
    };

    this.customerService.add(payload).subscribe({
      next: (customer) => {
        this.authService.setSetupCompleted(true);

        this.snackBar.open(
          `✅ All done ${customer.person?.firstName}! Your profile's looking good.`,
          undefined,
          { duration: 1500 }
        );

        setTimeout(() => this.router.navigate(['/home']), 1500);
      },
      error: (err) => {
        console.error('Failed to finish setup:', err);
        this.snackBar.open(
          `😕 Hmm, couldn't save your info. Mind trying again?`,
          'Close',
          { duration: 4000 }
        );
      },
    });
  }
}
