
//import { UpdateReview } from '../review/update.review';
import { UpdateWarranty } from '../warranty/update.warranty';
//import { UpdateCamera } from '../camera/update.camera';
//import { UpdateDesktopPC } from '../desktop-pc/update.desktopPC';
//import { UpdateGamingConsole } from '../gaming-console/update.gaming.console';
//import { UpdateLaptop } from '../laptop/update.laptop';
//import { UpdatePhone } from '../phone/update.phone';
//import { UpdateTablet } from '../tablet/update.tablet';
//import { UpdateTelevision } from '../television/update.television';
import { UpdateAccessory } from '../accessory/update.accessory';
import {UpdateProductColor} from '../product-color/update.product.color';
import {UpdateReview} from '../review/update.review';
import {UpdateCamera} from '../camera/update.camera';
import {UpdateDesktopPC} from '../desktop-pc/update.desktopPC';
import {UpdateGamingConsole} from '../gaming-console/update.gaming.console';
import {UpdateLaptop} from '../laptop/update.laptop';
import {UpdatePhone} from '../phone/update.phone';
import {UpdateTablet} from '../tablet/update.tablet';
import {UpdateTelevision} from '../television/update.television';
import {UpdateProductProductTag} from '../product-product-tag/update.product.product.tag';

export class UpdateProduct {
  brand?: string;
  model?: string;
  description?: string;
  price?: number;
  allColorsStock?: number;
  productCategoryId?: number;
  productColors?: UpdateProductColor[];
  productProductTags?: UpdateProductProductTag[];
  reviews?: UpdateReview[];
  warranty?: UpdateWarranty;
  camera?: UpdateCamera;
  desktopPC?: UpdateDesktopPC;
  gamingConsole?: UpdateGamingConsole;
  laptop?: UpdateLaptop;
  phone?: UpdatePhone;
  tablet?: UpdateTablet;
  television?: UpdateTelevision;
  accessory?: UpdateAccessory;
  isDeleted?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.brand = data.brand;
    this.model = data.model;
    this.description = data.description;
    this.price = data.price;
    this.allColorsStock = data.allColorsStock;
    this.productCategoryId = data.productCategoryId;
    this.productColors = Array.isArray(data.productColors)
      ? data.productColors.map((x: any) => new UpdateProductColor(x))
      : undefined;
    this.productProductTags = Array.isArray(data.productProductTags)
      ? data.productProductTags.map((x: any) => new UpdateProductProductTag(x))
      : undefined;
    this.reviews = Array.isArray(data.reviews) ? data.reviews.map((x: any) => new UpdateReview(x)) : undefined;
    this.warranty = data.warranty ? new UpdateWarranty(data.warranty) : undefined;
    this.camera = data.camera ? new UpdateCamera(data.camera) : undefined;
    this.desktopPC = data.desktopPC ? new UpdateDesktopPC(data.desktopPC) : undefined;
    this.gamingConsole = data.gamingConsole ? new UpdateGamingConsole(data.gamingConsole) : undefined;
    this.laptop = data.laptop ? new UpdateLaptop(data.laptop) : undefined;
    this.phone = data.phone ? new UpdatePhone(data.phone) : undefined;
    this.tablet = data.tablet ? new UpdateTablet(data.tablet) : undefined;
    this.television = data.television ? new UpdateTelevision(data.television) : undefined;
    this.accessory = data.accessory ? new UpdateAccessory(data.accessory) : undefined;
    this.isDeleted = data.isDeleted;
  }
}
