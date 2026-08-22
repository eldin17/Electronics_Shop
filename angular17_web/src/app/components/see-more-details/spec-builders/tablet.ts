import { boolRow, row, SpecSection } from './shared';

export function tabletSections(p: any): SpecSection[] {
  return [
    {
      title: 'Display',
      rows: [
        row('Screen Size', p.screenSize),
        row('Screen Resolution', p.screenResolution),
        row('Screen Type', p.screenType),
        row('Refresh Rate', p.refreshRate, ' Hz'),
      ],
    },
    {
      title: 'Performance',
      rows: [
        row('Processor', p.processor),
        row('RAM', p.ram, ' GB'),
        row('Storage', p.storageCapacity, ' GB'),
        boolRow('Expandable Storage', p.supportsExpandableStorage),
      ],
    },
    {
      title: 'Camera',
      rows: [
        row('Rear Camera', p.rearCameraResolution),
        row('Front Camera', p.frontCameraResolution),
      ],
    },
    {
      title: 'Battery',
      rows: [
        row('Battery Capacity', p.batteryCapacity, ' mAh'),
        row('Battery Life', p.estimatedBatteryLife, ' hours'),
        boolRow('Fast Charging', p.supportsFastCharging),
        boolRow('Wireless Charging', p.supportsWirelessCharging),
      ],
    },
    {
      title: 'Connectivity',
      rows: [
        boolRow('5G Support', p.supports5G),
        boolRow('WiFi 6', p.hasWiFi6),
        boolRow('Bluetooth', p.hasBluetooth),
        boolRow('Cellular', p.hasCellular),
      ],
    },
    {
      title: 'Additional Features',
      rows: [
        row('Operating System', p.operatingSystem),
        boolRow('Stylus Support', p.supportsStylus),
        boolRow('Fingerprint Sensor', p.hasFingerprintSensor),
        boolRow('Face Recognition', p.hasFaceRecognition),
        boolRow('Water Resistant', p.isWaterResistant),
      ],
    },
    {
      title: 'Physical Characteristics',
      rows: [
        row('Weight', p.weight, ' g'),
        row('Dimensions', p.dimensions),
        row('Build Material', p.buildMaterial),
      ],
    },
  ];
}
