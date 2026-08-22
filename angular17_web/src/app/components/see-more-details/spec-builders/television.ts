import { boolRow, row, SpecSection } from './shared';

export function televisionSections(p: any): SpecSection[] {
  return [
    {
      title: 'Display',
      rows: [
        row('Screen Size', p.screenSize),
        row('Resolution', p.screenResolution),
        row('Screen Type', p.screenType),
        boolRow('Smart TV', p.isSmartTV),
        row('Refresh Rate', p.refreshRate, ' Hz'),
        boolRow('HDR Support', p.supportsHDR),
      ],
    },
    {
      title: 'Audio',
      rows: [
        row('Speaker Output', p.speakerOutputPower, ' W'),
        boolRow('Dolby Atmos', p.supportsDolbyAtmos),
      ],
    },
    {
      title: 'Connectivity',
      rows: [
        row('HDMI Inputs', p.hdmiInputs),
        row('USB Ports', p.usbPorts),
        boolRow('Bluetooth', p.hasBluetooth),
        boolRow('WiFi', p.hasWiFi),
      ],
    },
    {
      title: 'Features',
      rows: [
        row('Operating System', p.operatingSystem),
        boolRow('Voice Control', p.supportsVoiceControl),
        boolRow('Screen Mirroring', p.hasScreenMirroring),
      ],
    },
    {
      title: 'Physical Characteristics',
      rows: [
        row('Weight', p.weight, ' kg'),
        row('Dimensions', p.dimensions),
        row('Stand Type', p.standType),
      ],
    },
    {
      title: 'Energy Efficiency',
      rows: [
        row('Energy Rating', p.energyRating),
        row('Power Consumption', p.powerConsumption, ' W'),
      ],
    },
  ];
}
