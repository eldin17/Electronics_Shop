import { boolRow, row, SpecSection } from './shared';

export function phoneSections(p: any): SpecSection[] {
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
        row('Storage Capacity', p.storageCapacity, ' GB'),
        boolRow('Expandable Storage', p.supportsExpandableStorage),
      ],
    },
    {
      title: 'Camera',
      rows: [
        row('Rear Cameras', p.rearCamerasCount),
        row('Main Camera', p.mainCameraResolution, ' MP'),
        row('Front Camera', p.frontCameraResolution, ' MP'),
        boolRow('Ultrawide Lens', p.hasUltrawideLens),
        boolRow('Zoom Lens', p.hasZoomLens),
      ],
    },
    {
      title: 'Battery',
      rows: [
        row('Battery Capacity', p.batteryCapacity, ' mAh'),
        boolRow('Fast Charging', p.supportsFastCharging),
        boolRow('Wireless Charging', p.supportsWirelessCharging),
        row('Estimated Battery Life', p.estimatedBatteryLife, ' hours'),
      ],
    },
    {
      title: 'Connectivity',
      rows: [
        boolRow('5G Support', p.supports5G),
        boolRow('WiFi 6', p.hasWiFi6),
        boolRow('Bluetooth', p.hasBluetooth),
        boolRow('NFC', p.hasNFC),
        boolRow('Dual SIM', p.hasDualSIM),
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
    {
      title: 'Additional Features',
      rows: [
        row('Operating System', p.operatingSystem),
        boolRow('Fingerprint Sensor', p.hasFingerprintSensor),
        boolRow('Face Recognition', p.hasFaceRecognition),
        boolRow('Water Resistant', p.isWaterResistant),
      ],
    },
  ];
}
