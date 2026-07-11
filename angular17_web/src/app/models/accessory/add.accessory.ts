import {AddAccessoryProperty} from '../accessory-property/add.accessory.property';

export class AddAccessory {
  name!: string;
  description!: string;
  productId!: number;
  accessoryCategoryId!: number;
  accessoryProperties?: AddAccessoryProperty[];

  constructor(data?: any) {
    if (!data) return;

    this.name = data.name;
    this.description = data.description;
    this.productId = data.productId;
    this.accessoryCategoryId = data.accessoryCategoryId;
    this.accessoryProperties = Array.isArray(data.accessoryProperties)
      ? data.accessoryProperties.map((x: any) => new AddAccessoryProperty(x))
      : undefined;
  }
}
