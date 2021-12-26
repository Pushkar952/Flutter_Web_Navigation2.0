import 'package:flutter/material.dart';
import '../core.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
