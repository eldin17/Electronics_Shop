export class Image {
  id!: number;
  name!: string;
  path!: string;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.name = data.name;
    this.path = data.path;
  }
}
