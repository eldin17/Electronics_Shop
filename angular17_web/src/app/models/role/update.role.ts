export class UpdateRole {
  roleName?: string;
  isDeleted?: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.roleName = data.roleName;
    this.isDeleted = data.isDeleted;
  }
}
