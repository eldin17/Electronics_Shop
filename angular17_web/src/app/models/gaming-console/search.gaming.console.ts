import { BaseSearch } from "../base.search";

export interface SearchGamingConsole extends BaseSearch {
  id?: number;
  productId?: number;
  processor?: string;
  graphicsProcessor?: string;
  ram?: number;
  storageType?: string;
  storageCapacity?: number;
  maxResolution?: string;
  maxFPS?: number;
  usbPorts?: number;
  hasWiFi?: boolean;
  hasBluetooth?: boolean;
  hasEthernetPort?: boolean;
  supportsExternalStorage?: boolean;
  supportsVR?: boolean;
  hasPhysicalMediaDrive?: boolean;
  isPortable?: boolean;
  controllerType?: string;
  supportsBackwardCompatibility?: boolean;
  onlineService?: string;
  weight?: number;
  dimensions?: string;
}
