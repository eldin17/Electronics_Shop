import { Component, ElementRef, HostListener, forwardRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, NG_VALUE_ACCESSOR, ControlValueAccessor } from '@angular/forms';
import {COUNTRIES, Country} from '../../helpers/countries';


@Component({
  selector: 'app-country-picker',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './country-picker.html',
  styleUrl: './country-picker.css',
  providers: [
    {
      provide: NG_VALUE_ACCESSOR,
      useExisting: forwardRef(() => CountryPicker),
      multi: true,
    },
  ],
})
export class CountryPicker implements ControlValueAccessor {
  countries = COUNTRIES;
  search = '';
  isOpen = false;
  selected: Country | null = null;
  disabled = false;

  private onChange: (value: string) => void = () => {};
  private onTouched: () => void = () => {};

  constructor(private elementRef: ElementRef) {}

  get filteredCountries(): Country[] {
    const term = this.search.trim().toLowerCase();
    if (!term) return this.countries;
    return this.countries.filter((c) => c.name.toLowerCase().includes(term));
  }

  toggleOpen(): void {
    if (this.disabled) return;
    this.isOpen = !this.isOpen;
    if (this.isOpen) {
      this.search = '';
    } else {
      this.onTouched();
    }
  }

  selectCountry(country: Country): void {
    this.selected = country;
    this.isOpen = false;
    this.onChange(country.name);
    this.onTouched();
  }

  @HostListener('document:click', ['$event.target'])
  onOutsideClick(target: EventTarget | null): void {
    if (this.isOpen && target instanceof Node && !this.elementRef.nativeElement.contains(target)) {
      this.isOpen = false;
      this.onTouched();
    }
  }

  writeValue(value: string): void {
    this.selected = value ? this.countries.find((c) => c.name === value) ?? { code: '', name: value } : null;
  }

  registerOnChange(fn: (value: string) => void): void {
    this.onChange = fn;
  }

  registerOnTouched(fn: () => void): void {
    this.onTouched = fn;
  }

  setDisabledState(isDisabled: boolean): void {
    this.disabled = isDisabled;
  }
}
