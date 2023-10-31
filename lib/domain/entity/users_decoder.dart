
import 'dart:convert';

import 'package:tinderlike/domain/entity/user.dart';
import 'package:tinderlike/domain/entity/users.dart';

class JsonUsersDecoder {
  Users decode(String jsonString) {
    final json = jsonDecode(jsonString) as List<dynamic>;
    final usersFromServer = json.map((dynamic e) => User.fromJson(e as Map<String, dynamic>)).toList();
   Users users =Users(usersFromServer);
   return users;
  }
}