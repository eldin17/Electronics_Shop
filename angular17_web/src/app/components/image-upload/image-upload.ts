import { Component, ChangeDetectorRef, EventEmitter, Input, Output } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-image-upload',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './image-upload.html',
  styleUrl: './image-upload.css',
})
export class ImageUpload {
  @Input() imageUrl: string | ArrayBuffer | null = null;

  @Input() defaultImage = '/assets/images/Logo2.jpg';

  @Input() caption = 'Click to add image';

  @Output() fileSelected = new EventEmitter<File>();

  selectedFile: File | null = null;

  constructor(private cdr: ChangeDetectorRef) {}

  onFileChange(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (!input.files || input.files.length === 0) {
      return;
    }

    this.selectedFile = input.files[0];
    this.fileSelected.emit(this.selectedFile);

    const reader = new FileReader();
    reader.onload = () => {
      this.imageUrl = reader.result;
      this.cdr.detectChanges();
    };
    reader.readAsDataURL(this.selectedFile);
  }
}
