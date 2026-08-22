import { row, SpecSection } from './shared';

export function accessorySections(a: any): SpecSection[] {
  const properties = a?.accessoryProperties ?? [];
  return [
    {
      title: 'General',
      rows: properties.map((prop: any) => row(prop.propertyName ?? '', prop.propertyValue)),
    },
  ];
}
