import { Product } from '../product/product';
import { ProductColor } from '../product-color/product.color';

export class OrderItem {
  id!: number;
  quantity!: number;
  price!: number;
  orderId!: number;
  product!: Product;
  finalPrice!: number;
  productColorId!: number;
  productColor!: ProductColor;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.quantity = data.quantity;
    this.price = data.price;
    this.orderId = data.orderId;
    this.product = data.product ? new Product(data.product) : undefined as any;
    this.finalPrice = data.finalPrice;
    this.productColorId = data.productColorId;
    this.productColor = data.productColor ? new ProductColor(data.productColor) : undefined as any;
  }
}
