import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String routeName;

  const Home({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Home Screen",
        style: TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }
}
