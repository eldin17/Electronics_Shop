export class Phone {
  id!: number;
  productId!: number;

  // Display
  screenSize!: string;
  screenResolution!: string;
  screenType!: string;
  refreshRate!: number;

  // Performance
  processor!: string;
  ram!: number;
  storageCapacity!: number;
  supportsExpandableStorage!: boolean;

  // Camera
  rearCamerasCount!: number;
  hasUltrawideLens!: boolean;
  hasZoomLens!: boolean;
  mainCameraResolution!: number;
  frontCameraResolution!: number;

  // Battery
  batteryCapacity!: number;
  supportsFastCharging!: boolean;
  supportsWirelessCharging!: boolean;
  estimatedBatteryLife!: number;

  // Connectivity
  supports5G!: boolean;
  hasWiFi6!: boolean;
  hasBluetooth!: boolean;
  hasNFC!: boolean;
  hasDualSIM!: boolean;

  // Physical Characteristics
  weight!: number;
  dimensions!: string;
  buildMaterial!: string;

  // Additional Features
  operatingSystem!: string;
  hasFingerprintSensor!: boolean;
  hasFaceRecognition!: boolean;
  isWaterResistant!: boolean;

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
    this.rearCamerasCount = data.rearCamerasCount;
    this.hasUltrawideLens = data.hasUltrawideLens;
    this.hasZoomLens = data.hasZoomLens;
    this.mainCameraResolution = data.mainCameraResolution;
    this.frontCameraResolution = data.frontCameraResolution;
    this.batteryCapacity = data.batteryCapacity;
    this.supportsFastCharging = data.supportsFastCharging;
    this.supportsWirelessCharging = data.supportsWirelessCharging;
    this.estimatedBatteryLife = data.estimatedBatteryLife;
    this.supports5G = data.supports5G;
    this.hasWiFi6 = data.hasWiFi6;
    this.hasBluetooth = data.hasBluetooth;
    this.hasNFC = data.hasNFC;
    this.hasDualSIM = data.hasDualSIM;
    this.weight = data.weight;
    this.dimensions = data.dimensions;
    this.buildMaterial = data.buildMaterial;
    this.operatingSystem = data.operatingSystem;
    this.hasFingerprintSensor = data.hasFingerprintSensor;
    this.hasFaceRecognition = data.hasFaceRecognition;
    this.isWaterResistant = data.isWaterResistant;
  }
}
