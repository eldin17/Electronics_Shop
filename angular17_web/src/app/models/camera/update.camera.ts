export class UpdateCamera {
  id?: number;
  productId?: number;

  megapixels?: number;
  sensorType?: string;
  lensMount?: string;
  videoResolution?: string;

  weight?: number;
  dimensions?: string;

  hasWiFi?: boolean;
  hasBluetooth?: boolean;

  batteryType?: string;
  batteryLife?: number;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.productId = data.productId;

    this.megapixels = data.megapixels;
    this.sensorType = data.sensorType;
    this.lensMount = data.lensMount;
    this.videoResolution = data.videoResolution;

    this.weight = data.weight;
    this.dimensions = data.dimensions;

    this.hasWiFi = data.hasWiFi;
    this.hasBluetooth = data.hasBluetooth;

    this.batteryType = data.batteryType;
    this.batteryLife = data.batteryLife;
  }
}
