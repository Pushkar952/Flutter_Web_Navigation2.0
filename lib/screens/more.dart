import 'package:flutter/material.dart';

class More extends StatelessWidget {
  final String routeName;

  const More({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "More Screen",
        style: TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }
}
