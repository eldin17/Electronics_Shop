export interface LoginRequest {
  username: string;
  password: string;
}

export interface DtoLogin {
  token: string;
  userId: number;
  roleName: string;
  isCustomer: boolean;
  isSeller: boolean;
}
