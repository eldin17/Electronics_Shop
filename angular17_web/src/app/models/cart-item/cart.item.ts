import {Product} from '../product/product';
import {ProductColor} from '../product-color/product.color';

export class CartItem {
  id!: number;
  quantity!: number;
  productId!: number;
  product?: Product;
  shoppingCartId!: number;
  finalPrice!: number;
  productColorId!: number;
  productColor?: ProductColor;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.quantity = data.quantity;
    this.productId = data.productId;
    this.product = data.product ? new Product(data.product) : undefined;
    this.shoppingCartId = data.shoppingCartId;
    this.finalPrice = data.finalPrice;
    this.productColorId = data.productColorId;
    this.productColor = data.productColor ? new ProductColor(data.productColor) : undefined;
  }
}
