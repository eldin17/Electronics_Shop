export class AccessoryProperty {
  id!: number;
  propertyName!: string;
  propertyValue!: string;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.propertyName = data.propertyName;
    this.propertyValue = data.propertyValue;
  }
}
