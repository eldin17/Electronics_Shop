import { BaseSearch } from "../base.search";

export interface SearchTelevision extends BaseSearch {
  id?: number;
  productId?: number;
  screenSize?: string;
  screenResolution?: string;
  screenType?: string;
  isSmartTV?: boolean;
  refreshRate?: number;
  supportsHDR?: boolean;
  speakerOutputPower?: number;
  supportsDolbyAtmos?: boolean;
  hdmiInputs?: number;
  usbPorts?: number;
  hasBluetooth?: boolean;
  hasWiFi?: boolean;
  operatingSystem?: string;
  supportsVoiceControl?: boolean;
  hasScreenMirroring?: boolean;
  weight?: number;
  dimensions?: string;
  standType?: string;
  energyRating?: string;
  powerConsumption?: number;
}
