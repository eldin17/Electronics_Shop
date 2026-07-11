import {AddProductColor} from '../product-color/add.product.color';
import {AddWarranty} from '../warranty/add.warranty';
import {AddDesktopPC} from '../desktop-pc/add.desktopPC';
import {AddCamera} from '../camera/add.camera';
import {AddGamingConsole} from '../gaming-console/add.gaming.console';
import {AddLaptop} from '../laptop/add.laptop';
import {AddPhone} from '../phone/add.phone';
import {AddTablet} from '../tablet/add.tablet';
import {AddTelevision} from '../television/add.television';
import {AddAccessory} from '../accessory/add.accessory';
import {AddProductProductTag} from '../product-product-tag/add.product.product.tag';

export class AddProduct {
  brand!: string;
  model!: string;
  description!: string;
  price!: number;

  productCategoryId!: number;
  productProductTags?: AddProductProductTag[];
  productColors!: AddProductColor[];
  warranty?: AddWarranty;

  camera?: AddCamera;
  desktopPC?: AddDesktopPC;
  gamingConsole?: AddGamingConsole;
  laptop?: AddLaptop;
  phone?: AddPhone;
  tablet?: AddTablet;
  television?: AddTelevision;

  accessory?: AddAccessory;
  isDeleted?: boolean;
  stateMachine?: string;

  constructor(data?: any) {
    if (!data) return;

    this.brand = data.brand;
    this.model = data.model;
    this.description = data.description;
    this.price = data.price;

    this.productCategoryId = data.productCategoryId;
    this.productProductTags = Array.isArray(data.productProductTags)
      ? data.productProductTags.map((x: any) => new AddProductProductTag(x))
      : undefined;
    this.productColors = Array.isArray(data.productColors)
      ? data.productColors.map((x: any) => new AddProductColor(x))
      : [];
    this.warranty = data.warranty ? new AddWarranty(data.warranty) : undefined;

    this.camera = data.camera ? new AddCamera(data.camera) : undefined;
    this.desktopPC = data.desktopPC ? new AddDesktopPC(data.desktopPC) : undefined;
    this.gamingConsole = data.gamingConsole ? new AddGamingConsole(data.gamingConsole) : undefined;
    this.laptop = data.laptop ? new AddLaptop(data.laptop) : undefined;
    this.phone = data.phone ? new AddPhone(data.phone) : undefined;
    this.tablet = data.tablet ? new AddTablet(data.tablet) : undefined;
    this.television = data.television ? new AddTelevision(data.television) : undefined;

    this.accessory = data.accessory ? new AddAccessory(data.accessory) : undefined;
    this.isDeleted = data.isDeleted;
    this.stateMachine = data.stateMachine;
  }
}
