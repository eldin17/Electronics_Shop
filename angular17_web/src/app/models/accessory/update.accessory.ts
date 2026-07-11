import { UpdateAccessoryProperty } from '../accessory-property/update.accessory.property';

export class UpdateAccessory {
  id?: number;
  name?: string;
  description?: string;
  productId?: number;
  accessoryCategoryId?: number;
  accessoryProperties?: UpdateAccessoryProperty[];

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.name = data.name;
    this.description = data.description;
    this.productId = data.productId;
    this.accessoryCategoryId = data.accessoryCategoryId;
    this.accessoryProperties = Array.isArray(data.accessoryProperties)
      ? data.accessoryProperties.map((x: any) => new UpdateAccessoryProperty(x))
      : undefined;
  }
}
