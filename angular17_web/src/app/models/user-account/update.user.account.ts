export class UpdateUserAccount {
  username?: string;
  email?: string;

  constructor(data?: any) {
    if (!data) return;

    this.username = data.username;
    this.email = data.email;
  }
}
