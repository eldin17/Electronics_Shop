export class DesktopPC {
  id!: number;
  productId!: number;

  processor!: string;
  ram!: number;
  storageType!: string;
  storageCapacity!: number;
  graphicsCard!: string;
  operatingSystem!: string;

  formFactor!: string;
  weight!: number;
  dimensions!: string;

  usbPorts!: number;
  hasWiFi!: boolean;
  hasBluetooth!: boolean;

  powerSupplyWattage!: number;

  coolingType!: string;

  hasRGBLighting!: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.productId = data.productId;

    this.processor = data.processor;
    this.ram = data.ram;
    this.storageType = data.storageType;
    this.storageCapacity = data.storageCapacity;
    this.graphicsCard = data.graphicsCard;
    this.operatingSystem = data.operatingSystem;

    this.formFactor = data.formFactor;
    this.weight = data.weight;
    this.dimensions = data.dimensions;

    this.usbPorts = data.usbPorts;
    this.hasWiFi = data.hasWiFi;
    this.hasBluetooth = data.hasBluetooth;

    this.powerSupplyWattage = data.powerSupplyWattage;

    this.coolingType = data.coolingType;

    this.hasRGBLighting = data.hasRGBLighting;
  }
}
