import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:motd/service/model/photo_response.dart';
import 'package:motd/service/photo_sort_type.dart';

class PhotoService {
  // todo change to firebase service
  // final String baseUrl = "https://picsum.photos/";
  final String baseUrl = "https://official-joke-api.appspot.com/random_joke";
  final String photo = "200";

  void getPhotos({PhotoSortType? type = PhotoSortType.recent}) async {
    // final url = Uri.parse('$baseUrl/$photo');
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final json = PhotoResponse.fromJson(result);
      print(json);
      return;
    }
    throw Error();
  }
}
