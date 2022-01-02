import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String routeName;
  const Profile({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Profile Screen",
        style: TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }
}
