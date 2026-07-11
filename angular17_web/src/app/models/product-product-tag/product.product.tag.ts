import { ProductTag } from '../product-tag/product.tag';

export class ProductProductTag {
  id!: number;
  productTag!: ProductTag;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.productTag = data.productTag ? new ProductTag(data.productTag) : undefined as any;
  }
}
