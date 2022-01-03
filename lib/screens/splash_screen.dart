import 'dart:async';

import 'package:flutter/material.dart';
import '../core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
