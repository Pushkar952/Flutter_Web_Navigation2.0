import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/core.dart';
import 'package:flutter_web_navigation/services/hive_storage_service.dart';

class MainScreen extends StatefulWidget {
  // Receives the name of the route from router delegate
  final String routeName;

  const MainScreen({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _key = CustomNavigationKeys.homeScaffoldKey;

  Widget? render;

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
      body: Row(
        key: UniqueKey(),
        children: [
          Drawer(
            elevation: 1,
            child: ListView.builder(
                itemCount: routeList.length,
                itemBuilder: (context, i) {
                  return _navTile(routeList[i]);
                }),
          ),
          Expanded(
            child: Center(
              child: render ??
                  Text(
                    widget.routeName,
                    style: const TextStyle(color: Colors.blue, fontSize: 16),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    RenderData? renderData;
    renderData = RouteHandeler().getRouteWidget(widget.routeName, _key);

    if (renderData?.pathName != null) {
      WidgetsBinding.instance?.addPostFrameCallback((duration) {
        String pathName = renderData?.pathName ?? RouteData.home.name;
        AppRouterDelegate().setPathName(pathName);
      });
    }
    render = renderData?.widget;
  }

  _logOut() async {
    await HiveDataStorageService.logOutUser();
    AppRouterDelegate().setPathName(RouteData.login.name, loggedIn: false);
  }

  Widget _navTile(SubNavigationRoutes route) {
    return ListTile(
      leading: Icon(
        route.icon,
        color: widget.routeName.contains(route.route.name)
            ? Colors.blue
            : Colors.grey,
      ),
      title: Text(
        route.title,
        style: TextStyle(
          color: widget.routeName.contains(route.route.name)
              ? Colors.blue
              : Colors.grey,
        ),
      ),
      onTap: () {
        AppRouterDelegate().setPathName(route.route.name);
      },
    );
  }
}
