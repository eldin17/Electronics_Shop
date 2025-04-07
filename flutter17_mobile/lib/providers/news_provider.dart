import 'package:flutter17_mobile/models/news.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';

class NewsProvider extends BaseCRUDProvider<News> {

  NewsProvider() : super("api/News") ;

  @override
  News fromJson(data){
    return News.fromJson(data);
  }
}
