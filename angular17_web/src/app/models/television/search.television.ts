import { BaseSearch } from "../base.search";

export interface SearchTelevision extends BaseSearch {
  id?: number;
  productId?: number;
  screenType?: string;
  isSmartTV?: boolean;
  supportsHDR?: boolean;
  supportsDolbyAtmos?: boolean;
  hasBluetooth?: boolean;
  hasWiFi?: boolean;
  operatingSystem?: string;
  supportsVoiceControl?: boolean;
  hasScreenMirroring?: boolean;
  standType?: string;
  energyRating?: string;
}
