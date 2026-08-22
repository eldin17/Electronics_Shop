import { boolRow, row, SpecSection } from './shared';

export function laptopSections(p: any): SpecSection[] {
  return [
    {
      title: 'Performance',
      rows: [
        row('Processor', p.processor),
        row('RAM', p.ram, ' GB'),
        row('Storage Type', p.storageType),
        row('Storage Capacity', p.storageCapacity, ' GB'),
        row('Graphics Card', p.graphicsCard),
      ],
    },
    {
      title: 'Display',
      rows: [
        row('Screen Size', p.screenSize),
        row('Screen Resolution', p.screenResolution),
        row('Screen Type', p.screenType),
      ],
    },
    {
      title: 'Battery',
      rows: [
        row('Battery Capacity', p.batteryCapacity, ' Wh'),
        row('Battery Life', p.batteryLife, ' hours'),
      ],
    },
    {
      title: 'Connectivity',
      rows: [
        boolRow('WiFi', p.hasWiFi),
        boolRow('Bluetooth', p.hasBluetooth),
        row('USB Ports', p.usbPorts),
        boolRow('Ethernet Port', p.hasEthernetPort),
        boolRow('HDMI', p.hasHDMI),
        boolRow('Thunderbolt', p.hasThunderbolt),
      ],
    },
    {
      title: 'Physical Characteristics',
      rows: [
        row('Weight', p.weight, ' kg'),
        row('Dimensions', p.dimensions),
        row('Build Material', p.buildMaterial),
      ],
    },
    {
      title: 'Additional Features',
      rows: [
        boolRow('Backlit Keyboard', p.hasBacklitKeyboard),
        boolRow('Fingerprint Reader', p.hasFingerprintReader),
        boolRow('Webcam', p.hasWebcam),
        row('Operating System', p.operatingSystem),
      ],
    },
  ];
}
