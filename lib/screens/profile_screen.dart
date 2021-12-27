import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/core.dart';
import 'package:flutter_web_navigation/services/hive_storage_service.dart';

class ProfileScreen extends StatefulWidget {
  // Receives the name of the route from router delegate
  final String routeName;

  const ProfileScreen({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _user = '';
  @override
  void initState() {
    _getUser();
    super.initState();
  }

  _getUser() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _user = await HiveDataStorageService.getUser();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => _logOut(),
              child: const Center(
                child: Text(
                  'Log Out ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 80,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          child: Text(
            _getRoute(widget.routeName).length > 1
                ? ('Welcome ${_getRoute(widget.routeName)[1]} !!!')
                : ('Welcome $_user'),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  _logOut() async {
    await HiveDataStorageService.logOutUser();
    AppRouterDelegate().setPathName(RouteData.login.name, loggedIn: false);
  }

  List<String> _getRoute(String routeName) {
    List<String> _temp = routeName.split('/');
    return _temp;
  }
}
