import 'package:flutter17_mobile/models/wishlist_item.dart';
import 'package:flutter17_mobile/providers/base_crud_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WishlistItemProvider extends BaseCRUDProvider<WishlistItem> {
  WishlistItemProvider() : super("api/WishlistItem");

  @override
  WishlistItem fromJson(data) {
    return WishlistItem.fromJson(data);
  }

  Future<WishlistItem> deleteByProductId(int productId, int wishlistId) async {
    var url =
        "${baseUrl}api/WishlistItem/DeleteByProductId?productId=$productId&wishlistId=$wishlistId";

    var headers = await getHeaders(withAuth: true);
    var uri = Uri.parse(url);

    print(uri);

    try {
      var response = await sendWithRefresh(
          (headers) => http.delete(uri, headers: headers));
      // var response = await http.delete(
      //   uri,
      //   headers: headers,
      // );

      if (isValidResponse(response)) {
        var data = jsonDecode(response.body);

        // Assuming fromJson handles the DtoWishlistItem conversion
        var result = WishlistItem.fromJson(data);

        return result;
      } else {
        throw Exception(
            "Server returned invalid response: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Action failed: ${e.toString()}");
    }
  }
}
