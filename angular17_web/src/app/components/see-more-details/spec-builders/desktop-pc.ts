import { boolRow, row, SpecSection } from './shared';

export function desktopPCSections(p: any): SpecSection[] {
  return [
    {
      title: 'General Information',
      rows: [
        row('Processor', p.processor),
        row('RAM', p.ram, ' GB'),
        row('Storage Type', p.storageType),
        row('Storage Capacity', p.storageCapacity, ' GB'),
        row('Graphics Card', p.graphicsCard),
        row('Operating System', p.operatingSystem),
      ],
    },
    {
      title: 'Physical Characteristics',
      rows: [
        row('Form Factor', p.formFactor),
        row('Weight', p.weight, ' kg'),
        row('Dimensions', p.dimensions),
      ],
    },
    {
      title: 'Connectivity',
      rows: [
        row('USB Ports', p.usbPorts),
        boolRow('WiFi', p.hasWiFi),
        boolRow('Bluetooth', p.hasBluetooth),
      ],
    },
    {
      title: 'Power Supply',
      rows: [row('Power Supply Wattage', p.powerSupplyWattage, ' W')],
    },
    {
      title: 'Cooling',
      rows: [row('Cooling Type', p.coolingType)],
    },
    {
      title: 'Additional Features',
      rows: [boolRow('Has RGB Lighting', p.hasRGBLighting)],
    },
  ];
}
