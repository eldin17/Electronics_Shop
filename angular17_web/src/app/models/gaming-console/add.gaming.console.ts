export class AddGamingConsole {
  productId!: number;
  processor!: string;
  graphicsProcessor!: string;
  ram!: number;
  storageType!: string;
  storageCapacity!: number;
  maxResolution!: string;
  maxFPS!: number;
  usbPorts!: number;
  hasWiFi!: boolean;
  hasBluetooth!: boolean;
  hasEthernetPort!: boolean;
  supportsExternalStorage!: boolean;
  supportsVR!: boolean;
  hasPhysicalMediaDrive!: boolean;
  isPortable!: boolean;
  controllerType!: string;
  supportsBackwardCompatibility!: boolean;
  onlineService!: string;
  weight!: number;
  dimensions!: string;

  constructor(data?: any) {
    if (!data) return;

    this.productId = data.productId;
    this.processor = data.processor;
    this.graphicsProcessor = data.graphicsProcessor;
    this.ram = data.ram;
    this.storageType = data.storageType;
    this.storageCapacity = data.storageCapacity;
    this.maxResolution = data.maxResolution;
    this.maxFPS = data.maxFPS;
    this.usbPorts = data.usbPorts;
    this.hasWiFi = data.hasWiFi;
    this.hasBluetooth = data.hasBluetooth;
    this.hasEthernetPort = data.hasEthernetPort;
    this.supportsExternalStorage = data.supportsExternalStorage;
    this.supportsVR = data.supportsVR;
    this.hasPhysicalMediaDrive = data.hasPhysicalMediaDrive;
    this.isPortable = data.isPortable;
    this.controllerType = data.controllerType;
    this.supportsBackwardCompatibility = data.supportsBackwardCompatibility;
    this.onlineService = data.onlineService;
    this.weight = data.weight;
    this.dimensions = data.dimensions;
  }
}
