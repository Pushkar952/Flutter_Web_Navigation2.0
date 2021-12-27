import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/services/hive_storage_service.dart';
import '../core.dart';

/// AppRouterDelegate includes the parsed result from RoutesInformationParser
class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final AppRouterDelegate _instance = AppRouterDelegate._();
  factory AppRouterDelegate() => _instance;

  AppRouterDelegate._();
  String? pathName;
  bool isError = false;

  bool isLoggedIn = false;

  /// Keeps the app stack
  late List<Page> _stack = [];

  /// currentConfiguration detects a route information may have changed as a result of rebuild.
  @override
  RoutePath get currentConfiguration {
    if (isError) {
      return RoutePath.unknown();
    }

    if (pathName == null) {
      if (isLoggedIn == true) {
        if (pathName != RouteData.profile.name) {
          return RoutePath.otherPage(pathName);
        } else {
          return RoutePath.home(pathName);
        }
      } else {
        return RoutePath.home(RouteData.login.name);
      }
    }

    return RoutePath.otherPage(pathName);
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey =>
      CustomNavigationKeys.navigatorKey;

  /// App Stack - Profile screen and other known and unknown routes
  List<Page> get _appStack => [
        if (pathName!.contains(RouteData.profile.name))
          MaterialPage(
            key: ValueKey(RouteData.profile.name),
            child: ProfileScreen(
              key: ValueKey('$pathName'),
              routeName: pathName ?? RouteData.profile.name,
            ),
          )
        else
          MaterialPage(
            key: ValueKey(RouteData.unkownRoute.name),
            child: const UnknownRoute(),
          )
      ];

  /// Auth route
  List<Page> get _authStack => [
        MaterialPage(
          key: ValueKey(RouteData.login.name),
          child: Login(
            key: ValueKey('$pathName'),
          ),
        ),
      ];

  /// Splash stack
  List<Page> get _splashStack => [
        MaterialPage(
          key: ValueKey(RouteData.splash.name),
          child: SplashScreen(
            callback: (route) => setPathName(route),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    if (pathName == null) {
      _stack = _splashStack;
    } else if (isLoggedIn) {
      _stack = _appStack;
    } else {
      _stack = _authStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: _stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        pathName = null;
        isError = false;
        notifyListeners();
        return true;
      },
    );
  }

  /// setNewRoutePath is called when a new route has been pushed to the application.
  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    String _user = await HiveDataStorageService.getUser();
    if (_user.isNotEmpty) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }

    if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        if (isLoggedIn == true) {
          /// If logged in
          if (configuration.pathName == RouteData.login.name) {
            pathName = RouteData.profile.name;
            isError = false;
            notifyListeners();
          } else {
            pathName = configuration.pathName;
            isError = false;
            notifyListeners();
          }
        } else {
          pathName = RouteData.login.name;
        }
        isError = false;
        notifyListeners();
      } else {
        isError = true;
      }
      if (isLoggedIn == false) {
        pathName = RouteData.login.name;
        notifyListeners();
      }
    } else {
      pathName = "/";
    }
  }

  /// setPathName  sets url path
  void setPathName(String path, {bool loggedIn = true}) {
    pathName = path;
    isLoggedIn = loggedIn;
    notifyListeners();
  }
}
