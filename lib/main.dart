import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/app.dart';
import 'package:url_strategy/url_strategy.dart';

import 'services/hive_storage_service.dart';

void main() async {
  ///If you want to remove the leading hash (#) from the URL of your Flutter web app,
  ///you can simply call setPathUrlStrategy in the main function of your app:
  setPathUrlStrategy();
  bool isUserLoggedIn = await HiveDataStorageService.getUser();

  runApp(App(
    isLoggedIn: isUserLoggedIn,
  ));
}
