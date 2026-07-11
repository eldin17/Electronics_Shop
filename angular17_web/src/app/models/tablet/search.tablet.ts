import { BaseSearch } from "../base.search";

export interface SearchTablet extends BaseSearch {
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
  rearCameraResolution?: string;
  frontCameraResolution?: string;
  batteryCapacity?: number;
  estimatedBatteryLife?: number;
  supportsFastCharging?: boolean;
  supportsWirelessCharging?: boolean;
  supports5G?: boolean;
  hasWiFi6?: boolean;
  hasBluetooth?: boolean;
  hasCellular?: boolean;
  weight?: number;
  dimensions?: string;
  buildMaterial?: string;
  operatingSystem?: string;
  supportsStylus?: boolean;
  hasFingerprintSensor?: boolean;
  hasFaceRecognition?: boolean;
  isWaterResistant?: boolean;
}
