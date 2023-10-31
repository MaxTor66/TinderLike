import 'package:dio/dio.dart';
import 'package:tinderlike/domain/entity/users_decoder.dart';

import '../entity/users.dart';

class DataUsersProvider {
  final dio = Dio();

  Future<String> getUsersHttp() async {
    String jsonString = "";
    const String url = "https://jsonplaceholder.typicode.com/users";
    try {
      Options ops = Options(responseType: ResponseType.plain);
      final responseDio = await dio.get(
        url,
        options: ops,
        queryParameters: {},
      );

      jsonString = responseDio.toString();
    } catch (e) {
      throw 'There is no connection';
    }

    return jsonString;
  }

  Future<String> getAlbumsHttp(int userId) async {
    String jsonString = "";
    const String url = "https://jsonplaceholder.typicode.com/albums";
    try {
      Options ops = Options(responseType: ResponseType.plain);
      final responseDio = await dio.get(
        url,
        options: ops,
        queryParameters: {'userId': userId},
      );

      jsonString = responseDio.toString();
    } catch (e) {
      throw 'There is no connection';
    }

    return jsonString;
  }

  Future<String> getPhotosHttp(int albumId) async {
    String jsonString = "";
    const String url = "https://jsonplaceholder.typicode.com/photos";
    try {
      Options ops = Options(responseType: ResponseType.plain);
      final responseDio = await dio.get(
        url,
        options: ops,
        queryParameters: {'albumId': albumId},
      );

      jsonString = responseDio.toString();
    } catch (e) {
      throw 'There is no connection';
    }

    return jsonString;
  }

}
