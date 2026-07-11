import { BaseSearch } from "../base.search";

export interface SearchDesktopPC extends BaseSearch {
  id?: number;
  productId?: number;
  processor?: string;
  ram?: number;
  storageType?: string;
  storageCapacity?: number;
  graphicsCard?: string;
  operatingSystem?: string;
  formFactor?: string;
  weight?: number;
  dimensions?: string;
  usbPorts?: number;
  hasWiFi?: boolean;
  hasBluetooth?: boolean;
  powerSupplyWattage?: number;
  coolingType?: string;
  hasRGBLighting?: boolean;
}
