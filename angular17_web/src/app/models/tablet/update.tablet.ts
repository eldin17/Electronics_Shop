export class UpdateTablet {
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

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.productId = data.productId;
    this.screenSize = data.screenSize;
    this.screenResolution = data.screenResolution;
    this.screenType = data.screenType;
    this.refreshRate = data.refreshRate;
    this.processor = data.processor;
    this.ram = data.ram;
    this.storageCapacity = data.storageCapacity;
    this.supportsExpandableStorage = data.supportsExpandableStorage;
    this.rearCameraResolution = data.rearCameraResolution;
    this.frontCameraResolution = data.frontCameraResolution;
    this.batteryCapacity = data.batteryCapacity;
    this.estimatedBatteryLife = data.estimatedBatteryLife;
    this.supportsFastCharging = data.supportsFastCharging;
    this.supportsWirelessCharging = data.supportsWirelessCharging;
    this.supports5G = data.supports5G;
    this.hasWiFi6 = data.hasWiFi6;
    this.hasBluetooth = data.hasBluetooth;
    this.hasCellular = data.hasCellular;
    this.weight = data.weight;
    this.dimensions = data.dimensions;
    this.buildMaterial = data.buildMaterial;
    this.operatingSystem = data.operatingSystem;
    this.supportsStylus = data.supportsStylus;
    this.hasFingerprintSensor = data.hasFingerprintSensor;
    this.hasFaceRecognition = data.hasFaceRecognition;
    this.isWaterResistant = data.isWaterResistant;
  }
}
