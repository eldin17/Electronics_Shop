import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/adress.dart';

class AdressProvider extends BaseCRUDProvider<Adress> {

  AdressProvider() : super("api/Adress") ;

  @override
  Adress fromJson(data){
    return Adress.fromJson(data);
  }  
}