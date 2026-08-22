import { boolRow, row, SpecSection } from './shared';

export function cameraSections(p: any): SpecSection[] {
  return [
    {
      title: 'Sensor',
      rows: [
        row('Megapixels', p.megapixels != null ? Math.trunc(p.megapixels) : null),
        row('Sensor Type', p.sensorType),
        row('Lens Mount', p.lensMount),
        row('Video Resolution', p.videoResolution),
      ],
    },
    {
      title: 'Physical Characteristics',
      rows: [
        row('Weight', p.weight, ' kg'),
        row('Dimensions', p.dimensions, ' (cm)'),
      ],
    },
    {
      title: 'Connectivity',
      rows: [
        boolRow('WiFi', p.hasWiFi),
        boolRow('Bluetooth', p.hasBluetooth),
      ],
    },
    {
      title: 'Battery',
      rows: [
        row('Battery Type', p.batteryType),
        row('Battery Life', p.batteryLife, ' mAh'),
      ],
    },
  ];
}
