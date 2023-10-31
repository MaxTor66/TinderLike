import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tinderlike/ui/my_app.dart';

import 'domain/data_provider/data_provider_users.dart';

void main() {
  GetIt.instance.registerSingleton<DataUsersProvider>(DataUsersProvider());
  GetIt.I<DataUsersProvider>().dio;

  runApp(const MyApp());
}

