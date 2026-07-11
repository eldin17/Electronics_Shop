export class AccessoryCategory {
  id!: number;
  name!: string;
  isDeleted!: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.name = data.name;
    this.isDeleted = data.isDeleted;
  }
}
