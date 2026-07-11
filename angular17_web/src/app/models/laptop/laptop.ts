export class Laptop {
  id!: number;
  productId!: number;
  processor!: string;
  ram!: number;
  storageType!: string;
  storageCapacity!: number;
  graphicsCard!: string;
  screenSize!: string;
  screenResolution!: string;
  screenType!: string;
  batteryCapacity!: number;
  batteryLife!: number;
  hasWiFi!: boolean;
  hasBluetooth!: boolean;
  usbPorts!: number;
  hasEthernetPort!: boolean;
  hasHDMI!: boolean;
  hasThunderbolt!: boolean;
  weight!: number;
  dimensions!: string;
  buildMaterial!: string;
  hasBacklitKeyboard!: boolean;
  hasFingerprintReader!: boolean;
  hasWebcam!: boolean;
  operatingSystem!: string;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.productId = data.productId;
    this.processor = data.processor;
    this.ram = data.ram;
    this.storageType = data.storageType;
    this.storageCapacity = data.storageCapacity;
    this.graphicsCard = data.graphicsCard;
    this.screenSize = data.screenSize;
    this.screenResolution = data.screenResolution;
    this.screenType = data.screenType;
    this.batteryCapacity = data.batteryCapacity;
    this.batteryLife = data.batteryLife;
    this.hasWiFi = data.hasWiFi;
    this.hasBluetooth = data.hasBluetooth;
    this.usbPorts = data.usbPorts;
    this.hasEthernetPort = data.hasEthernetPort;
    this.hasHDMI = data.hasHDMI;
    this.hasThunderbolt = data.hasThunderbolt;
    this.weight = data.weight;
    this.dimensions = data.dimensions;
    this.buildMaterial = data.buildMaterial;
    this.hasBacklitKeyboard = data.hasBacklitKeyboard;
    this.hasFingerprintReader = data.hasFingerprintReader;
    this.hasWebcam = data.hasWebcam;
    this.operatingSystem = data.operatingSystem;
  }
}
