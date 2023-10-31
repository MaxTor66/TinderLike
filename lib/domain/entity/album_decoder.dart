
import 'dart:convert';

import 'album.dart';


class JsonAlbumDecoder {
  List<Album> decode(String jsonString) {
    final json = jsonDecode(jsonString) as List<dynamic>;
    final albumsFromServer = json.map((dynamic e) => Album.fromJson(e as Map<String, dynamic>)).toList();

    return albumsFromServer;
  }
}