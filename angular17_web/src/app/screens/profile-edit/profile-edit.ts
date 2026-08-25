import { Component, OnInit } from '@angular/core';
import { CommonModule, Location } from '@angular/common';
import { FormsModule, NgForm } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { firstValueFrom } from 'rxjs';
import {CountryPicker} from '../../components/country-picker/country-picker';
import {ImageUpload} from '../../components/image-upload/image-upload';
import {AuthService} from '../../services/auth.service';
import {PersonService} from '../../services/person.service';
import {ImageService} from '../../services/image.service';
import {AddressService} from '../../services/address.service';
import {UserAccountService} from '../../services/user.account.service';



interface PersonModel {
  firstName: string;
  lastName: string;
  dateOfBirth: string;
}

interface AdressModel {
  street: string;
  city: string;
  country: string;
  postalCode: string;
}

interface ProfileEditModel {
  person: PersonModel;
  adress: AdressModel;
}


function toDateInputValue(value: unknown): string {
  if (!value) return '';

  const date = value instanceof Date ? value : new Date(value as string);
  if (isNaN(date.getTime())) return '';


  const yyyy = date.getUTCFullYear();
  const mm = String(date.getUTCMonth() + 1).padStart(2, '0');
  const dd = String(date.getUTCDate()).padStart(2, '0');
  return `${yyyy}-${mm}-${dd}`;
}

@Component({
  selector: 'app-profile-edit',
  standalone: true,
  imports: [CommonModule, FormsModule, CountryPicker, ImageUpload],
  templateUrl: './profile-edit.html',
  styleUrl: './profile-edit.css',
})
export class ProfileEdit implements OnInit {

  model: ProfileEditModel = {
    person: { firstName: '', lastName: '', dateOfBirth: '' },
    adress: { street: '', city: '', country: '', postalCode: '' },
  };

  private initialModel!: ProfileEditModel;

  private userAccId!: number;
  private personId!: number;
  private adressId!: number;

  imagePreview: string | ArrayBuffer | null = null;
  selectedFile: File | null = null;
  isLoading = true;

  constructor(
    private authService: AuthService,
    private personService: PersonService,
    private adressService: AddressService,
    private imageService: ImageService,
    private userAccountService: UserAccountService,
    private location: Location,
    private snackBar: MatSnackBar,
  ) {}

  async ngOnInit(): Promise<void> {

    const userAccId = this.authService.getUserId();
    if (!userAccId) {
      this.snackBar.open('😕 Your session expired. Please log in again.', 'Close', { duration: 3000 });
      return;
    }

    const person = await firstValueFrom(this.personService.getByUserId(userAccId));
    const adressList = await firstValueFrom(this.adressService.getAll({ personId: person.id }));
    const adress = adressList.data[0];
    const userAcc = await firstValueFrom(this.userAccountService.getById(userAccId));

    this.userAccId = userAccId;
    this.personId = person.id;
    this.adressId = adress.id;

    this.model = {
      person: {
        firstName: person.firstName ?? '',
        lastName: person.lastName ?? '',
        dateOfBirth: toDateInputValue(person.dateOfBirth),
      },
      adress: {
        street: adress.street ?? '',
        city: adress.city ?? '',
        country: adress.country ?? '',
        postalCode: adress.postalCode ?? '',
      },
    };

    this.initialModel = JSON.parse(JSON.stringify(this.model));

    this.imagePreview = userAcc.image?.path ?? null;

    this.isLoading = false;
  }

  goBack(): void {
    this.location.back();
  }

  onImageSelected(file: File): void {
    this.selectedFile = file;
  }

  async onSubmit(form: NgForm) {
    if (form.invalid) {
      Object.values(form.controls).forEach(control => control.markAsTouched());
      return;
    }

    const { person, adress } = this.model;

    const personChanged =
      person.firstName !== this.initialModel.person.firstName ||
      person.lastName !== this.initialModel.person.lastName ||
      person.dateOfBirth !== this.initialModel.person.dateOfBirth;

    const addressChanged =
      adress.street !== this.initialModel.adress.street ||
      adress.city !== this.initialModel.adress.city ||
      adress.country !== this.initialModel.adress.country ||
      adress.postalCode !== this.initialModel.adress.postalCode;

    if (!personChanged && !addressChanged && !this.selectedFile) {
      this.snackBar.open('ℹ️ No changes were made.', 'Close', { duration: 3000 });
      this.goBack();
      return;
    }

    try {
      let displayName = person.firstName || this.initialModel.person.firstName;

      if (personChanged) {
        const dateOfBirthDate = person.dateOfBirth
          ? new Date(person.dateOfBirth + 'T00:00:00Z')
          : undefined;

        const updatedPerson = await firstValueFrom(this.personService.update(this.personId, {
          firstName: person.firstName,
          lastName: person.lastName,
          dateOfBirth: dateOfBirthDate,
        }));

        displayName = updatedPerson?.firstName ?? displayName;
      }

      if (addressChanged) {
        await firstValueFrom(this.adressService.update(this.adressId, {
          street: adress.street,
          city: adress.city,
          country: adress.country,
          postalCode: adress.postalCode,
        }));
      }

      if (this.selectedFile) {
        await firstValueFrom(this.imageService.uploadUserImage(this.userAccId, this.selectedFile));
      }

      this.snackBar.open(`✅ Nicely done, ${displayName}! Everything’s up to date.`, 'Close', {
        duration: 3000,
      });

      this.goBack();
    } catch (err) {
      console.error('Profile update failed:', err);

      this.snackBar.open('😕 Hmm, couldn’t save your info. Mind trying again?', 'Close', {
        duration: 3000,
        panelClass: ['custom-error-snackbar'],
      });
    }
  }
}
