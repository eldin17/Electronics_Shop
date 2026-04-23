import 'package:flutter17_mobile/models/customer.dart';

class LoginResponse{
  static String? accessToken;
  static String? refreshToken;
  static int? userId;
  static String? roleName;
  static bool? isCustomer;
  static bool? isSeller;
  static Customer? currentCustomer;  
}