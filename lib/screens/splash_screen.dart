import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/services/hive_storage_service.dart';
import '../core.dart';

class SplashScreen extends StatefulWidget {
  final Function(String) callback;
  const SplashScreen({Key? key, required this.callback}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  // Evaluates the next logical route based on
  // user logged in state.
  _init() async {
    String _user = await HiveDataStorageService.getUser();
    if (_user.isEmpty) {
      widget.callback(RouteData.login.name);
    } else {
      widget.callback(RouteData.profile.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(80),
          child: Image(
            width: 200,
            height: 150,
            image: AssetImage(AllImages.flutterLogo),
          ),
        ),
      ),
    );
  }
}
