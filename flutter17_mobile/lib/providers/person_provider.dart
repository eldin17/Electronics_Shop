import 'package:flutter17_mobile/models/person.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PersonProvider extends BaseCRUDProvider<Person> {

  PersonProvider() : super("api/Person") ;

  @override
  Person fromJson(data){
    return Person.fromJson(data);
  }  
}