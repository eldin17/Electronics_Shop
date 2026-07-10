export class Pagination<T> {
  data: T[] = [];
  totalItems?: number | null;

  constructor(data?: any) {
    if (!data) return;
    this.data = data.data ?? [];
    this.totalItems = data.totalItems;
  }
}
