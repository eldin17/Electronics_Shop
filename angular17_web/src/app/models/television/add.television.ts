export class AddTelevision {
  productId!: number;
  screenSize!: string;
  screenResolution!: string;
  screenType!: string;
  isSmartTV!: boolean;
  refreshRate!: number;
  supportsHDR!: boolean;
  speakerOutputPower!: number;
  supportsDolbyAtmos!: boolean;
  hdmiInputs!: number;
  usbPorts!: number;
  hasBluetooth!: boolean;
  hasWiFi!: boolean;
  operatingSystem!: string;
  supportsVoiceControl!: boolean;
  hasScreenMirroring!: boolean;
  weight!: number;
  dimensions!: string;
  standType!: string;
  energyRating!: string;
  powerConsumption!: number;

  constructor(data?: any) {
    if (!data) return;

    this.productId = data.productId;
    this.screenSize = data.screenSize;
    this.screenResolution = data.screenResolution;
    this.screenType = data.screenType;
    this.isSmartTV = data.isSmartTV;
    this.refreshRate = data.refreshRate;
    this.supportsHDR = data.supportsHDR;
    this.speakerOutputPower = data.speakerOutputPower;
    this.supportsDolbyAtmos = data.supportsDolbyAtmos;
    this.hdmiInputs = data.hdmiInputs;
    this.usbPorts = data.usbPorts;
    this.hasBluetooth = data.hasBluetooth;
    this.hasWiFi = data.hasWiFi;
    this.operatingSystem = data.operatingSystem;
    this.supportsVoiceControl = data.supportsVoiceControl;
    this.hasScreenMirroring = data.hasScreenMirroring;
    this.weight = data.weight;
    this.dimensions = data.dimensions;
    this.standType = data.standType;
    this.energyRating = data.energyRating;
    this.powerConsumption = data.powerConsumption;
  }
}
