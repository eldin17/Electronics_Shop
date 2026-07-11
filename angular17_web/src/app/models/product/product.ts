import {Camera} from '../camera/camera';
import {DesktopPC} from '../desktop-pc/desktopPC';
import {GamingConsole} from '../gaming-console/gaming.console';
import {Laptop} from '../laptop/laptop';
import {Phone} from '../phone/phone';
import {Accessory} from '../accessory/accessory';
import {ProductColor} from '../product-color/product.color';
import {ProductDiscount} from '../product-discount/product.discount';
import {ProductCategory} from '../product-category/product.category';
import {ProductImage} from '../product-image/product.image';
import {ProductProductTag} from '../product-product-tag/product.product.tag';
import {Tablet} from '../tablet/tablet';
import {Television} from '../television/television';
import {Warranty} from '../warranty/warranty';


export class Product {
  id!: number;
  brand!: string;
  model!: string;
  description!: string;
  price!: number;
  finalPrice!: number;
  productCategoryId!: number;
  productCategory!: ProductCategory;
  productImages: ProductImage[] = [];
  productColors: ProductColor[] = [];
  productProductTags: ProductProductTag[] = [];
  warrantyId?: number;
  warranty?: Warranty;
  productDiscounts: ProductDiscount[] = [];
  camera?: Camera;
  desktopPC?: DesktopPC;
  gamingConsole?: GamingConsole;
  laptop?: Laptop;
  phone?: Phone;
  tablet?: Tablet;
  television?: Television;
  accessory?: Accessory;
  isDeleted!: boolean;
  reviewScoreAvg: number = 0;
  isFavourite: boolean = false;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.brand = data.brand;
    this.model = data.model;
    this.description = data.description;
    this.price = data.price;
    this.finalPrice = data.finalPrice;
    this.productCategoryId = data.productCategoryId;
    this.productCategory = data.productCategory ? new ProductCategory(data.productCategory) : undefined as any;
    this.productImages = Array.isArray(data.productImages) ? data.productImages.map((x: any) => new ProductImage(x)) : [];
    this.productColors = Array.isArray(data.productColors) ? data.productColors.map((x: any) => new ProductColor(x)) : [];
    this.productProductTags = Array.isArray(data.productProductTags) ? data.productProductTags.map((x: any) => new ProductProductTag(x)) : [];
    this.warrantyId = data.warrantyId;
    this.warranty = data.warranty ? new Warranty(data.warranty) : undefined;
    this.productDiscounts = Array.isArray(data.productDiscounts) ? data.productDiscounts.map((x: any) => new ProductDiscount(x)) : [];
    this.camera = data.camera ? new Camera(data.camera) : undefined;
    this.desktopPC = data.desktopPC ? new DesktopPC(data.desktopPC) : undefined;
    this.gamingConsole = data.gamingConsole ? new GamingConsole(data.gamingConsole) : undefined;
    this.laptop = data.laptop ? new Laptop(data.laptop) : undefined;
    this.phone = data.phone ? new Phone(data.phone) : undefined;
    this.tablet = data.tablet ? new Tablet(data.tablet) : undefined;
    this.television = data.television ? new Television(data.television) : undefined;
    this.accessory = data.accessory ? new Accessory(data.accessory) : undefined;
    this.isDeleted = data.isDeleted;
    this.reviewScoreAvg = data.reviewScoreAvg ?? 0;
    this.isFavourite = data.isFavourite ?? false;
  }
}
