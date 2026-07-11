export class Role {
  id!: number;
  roleName!: string;
  isDeleted!: boolean;

  constructor(data?: any) {
    if (!data) return;

    this.id = data.id;
    this.roleName = data.roleName;
    this.isDeleted = data.isDeleted;
  }
}
