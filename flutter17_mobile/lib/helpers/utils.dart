
import 'package:flutter17_mobile/models/image.dart';

String adjustImage(String image) {
  Uri uri = Uri.parse(image);
  Uri obj = uri.replace(host: '10.0.2.2');
  String path = obj.toString();
  return path;
}

List<String> adjustMultipleImages(List<Image> images) {
  List<String> returnObj = [];
  for (var item in images) {
    returnObj.add(adjustImage(item.path!));
  }
  return returnObj;
}