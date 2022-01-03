import 'package:flutter/material.dart';

import '../core.dart';

class More extends StatelessWidget {
  final String routeName;

  const More({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        getRouteParams(routeName).length > 1
            ? "More Screen with param ${getRouteParams(routeName)[1]}"
            : "More Screen",
        style: const TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }
}
