import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/core.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation 2.0',
      routeInformationParser: RoutesInformationParser(),
      routerDelegate: AppRouterDelegate(),
    );
  }
}
