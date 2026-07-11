import { BaseSearch } from "../base.search";

export interface SearchLaptop extends BaseSearch {
  id?: number;
  productId?: number;
  processor?: string;
  ram?: number;
  storageType?: string;
  storageCapacity?: number;
  graphicsCard?: string;
  screenSize?: string;
  screenResolution?: string;
  screenType?: string;
  batteryCapacity?: number;
  batteryLife?: number;
  hasWiFi?: boolean;
  hasBluetooth?: boolean;
  usbPorts?: number;
  hasEthernetPort?: boolean;
  hasHDMI?: boolean;
  hasThunderbolt?: boolean;
  weight?: number;
  dimensions?: string;
  buildMaterial?: string;
  hasBacklitKeyboard?: boolean;
  hasFingerprintReader?: boolean;
  hasWebcam?: boolean;
  operatingSystem?: string;
}
