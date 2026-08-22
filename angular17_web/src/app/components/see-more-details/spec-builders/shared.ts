export interface SpecRow {
  label: string;
  value: string;
}

export interface SpecSection {
  title: string;
  rows: SpecRow[];
}

export function row(label: string, value: unknown, unit = ''): SpecRow {
  if (value === null || value === undefined || value === '') {
    return { label, value: 'Not Available' };
  }
  return { label, value: `${value}${unit}` };
}

export function boolRow(label: string, value: boolean | null | undefined): SpecRow {
  return { label, value: value == null ? 'Not Available' : value ? 'Yes' : 'No' };
}
