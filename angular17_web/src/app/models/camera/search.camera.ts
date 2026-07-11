import { BaseSearch } from "../base.search";

export interface SearchCamera extends BaseSearch {
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
}
