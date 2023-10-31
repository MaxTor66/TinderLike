import 'dart:convert';

import 'photo.dart';


class JsonPhotoDecoder {
  List<Photo> decode(String jsonString) {
    final json = jsonDecode(jsonString) as List<dynamic>;
    final photosFromServer = json.map((dynamic e) => Photo.fromJson(e as Map<String, dynamic>)).toList();

    return photosFromServer;
  }
}