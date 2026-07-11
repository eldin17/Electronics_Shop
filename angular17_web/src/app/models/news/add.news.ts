export class AddNews {
  title!: string;
  content!: string;
  datePublished?: Date;

  constructor(data?: any) {
    if (!data) return;

    this.title = data.title;
    this.content = data.content;
    this.datePublished = data.datePublished ? new Date(data.datePublished) : undefined;
  }
}
