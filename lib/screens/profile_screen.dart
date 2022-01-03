import 'package:flutter/material.dart';

import '../core.dart';

class Profile extends StatelessWidget {
  final String routeName;
  const Profile({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        getRouteParams(routeName).length > 1
            ? "Profile Screen with param ${getRouteParams(routeName)[1]}"
            : "Profile Screen",
        style: const TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }
}
