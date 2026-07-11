export class News {
  id!: number;
  title!: string;
  content!: string;
  datePublished!: Date;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.title = data.title;
    this.content = data.content;
    this.datePublished = data.datePublished ? new Date(data.datePublished) : undefined as any;
  }
}
