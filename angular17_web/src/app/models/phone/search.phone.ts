import { BaseSearch } from "../base.search";

export interface SearchPhone extends BaseSearch {
  id?: number;
  productId?: number;


  screenSize?: string;
  screenResolution?: string;
  screenType?: string;
  refreshRate?: number;


  processor?: string;
  ram?: number;
  storageCapacity?: number;
  supportsExpandableStorage?: boolean;

  rearCamerasCount?: number;
  hasUltrawideLens?: boolean;
  hasZoomLens?: boolean;
  mainCameraResolution?: number;
  frontCameraResolution?: number;


  batteryCapacity?: number;
  supportsFastCharging?: boolean;
  supportsWirelessCharging?: boolean;
  estimatedBatteryLife?: number;


  supports5G?: boolean;
  hasWiFi6?: boolean;
  hasBluetooth?: boolean;
  hasNFC?: boolean;
  hasDualSIM?: boolean;


  weight?: number;
  dimensions?: string;
  buildMaterial?: string;


  operatingSystem?: string;
  hasFingerprintSensor?: boolean;
  hasFaceRecognition?: boolean;
  isWaterResistant?: boolean;
}
