import {Image} from '../image/image';
import {ProductColor} from '../product-color/product.color';


export class ProductImage {
  id!: number;
  productId!: number;
  image!: Image;
  productColor!: ProductColor;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.productId = data.productId;
    this.image = data.image ? new Image(data.image) : undefined as any;
    this.productColor = data.productColor ? new ProductColor(data.productColor) : undefined as any;
  }
}
