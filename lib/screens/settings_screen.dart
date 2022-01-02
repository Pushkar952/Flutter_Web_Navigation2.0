import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final String routeName;

  const Settings({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Settings Screen",
        style: TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }
}
