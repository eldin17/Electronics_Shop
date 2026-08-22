import { boolRow, row, SpecSection } from './shared';

export function gamingConsoleSections(p: any): SpecSection[] {
  return [
    {
      title: 'General Information',
      rows: [
        row('Processor', p.processor),
        row('Graphics Processor', p.graphicsProcessor),
      ],
    },
    {
      title: 'Performance',
      rows: [
        row('RAM', p.ram, ' GB'),
        row('Storage Type', p.storageType),
        row('Storage Capacity', p.storageCapacity, ' GB'),
        row('Max Resolution', p.maxResolution),
        row('Max FPS', p.maxFPS),
      ],
    },
    {
      title: 'Connectivity',
      rows: [
        row('USB Ports', p.usbPorts),
        boolRow('WiFi', p.hasWiFi),
        boolRow('Bluetooth', p.hasBluetooth),
        boolRow('Ethernet Port', p.hasEthernetPort),
        boolRow('External Storage', p.supportsExternalStorage),
      ],
    },
    {
      title: 'Features',
      rows: [
        boolRow('VR', p.supportsVR),
        boolRow('Physical Media Drive', p.hasPhysicalMediaDrive),
        boolRow('Portable', p.isPortable),
      ],
    },
    {
      title: 'Additional Features',
      rows: [
        row('Controller Type', p.controllerType),
        boolRow('Backward Compatibility', p.supportsBackwardCompatibility),
        row('Online Service', p.onlineService),
      ],
    },
    {
      title: 'Physical Characteristics',
      rows: [
        row('Weight', p.weight, ' kg'),
        row('Dimensions', p.dimensions),
      ],
    },
  ];
}
