import {AccessoryCategory} from '../accessory-category/accessory.category';
import {AccessoryProperty} from '../accessory-property/accessory.property';

export class Accessory {
  id!: number;
  name!: string;
  description!: string;
  productId!: number;
  accessoryCategory?: AccessoryCategory;
  accessoryProperties: AccessoryProperty[] = [];

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.name = data.name;
    this.description = data.description;
    this.productId = data.productId;

    this.accessoryCategory = data.accessoryCategory
     ? new AccessoryCategory(data.accessoryCategory)
     : undefined;
    this.accessoryProperties = Array.isArray(data.accessoryProperties)
     ? data.accessoryProperties.map((x: any) => new AccessoryProperty(x))
     : [];
  }
}
