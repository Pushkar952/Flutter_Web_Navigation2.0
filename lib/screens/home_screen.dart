import 'package:flutter/material.dart';

import '../core.dart';

class Home extends StatelessWidget {
  final String routeName;

  const Home({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        getRouteParams(routeName).length > 1
            ? "Home Screen with param  ${getRouteParams(routeName)[1]}"
            : "Home Screen",
        style: const TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }
}
