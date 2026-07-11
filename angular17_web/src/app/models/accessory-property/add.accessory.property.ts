export class AddAccessoryProperty {
  propertyName!: string;
  propertyValue!: string;
  accessoryId?: number;

  constructor(data?: any) {
    if (!data) return;

    this.propertyName = data.propertyName;
    this.propertyValue = data.propertyValue;
    this.accessoryId = data.accessoryId;
  }
}
