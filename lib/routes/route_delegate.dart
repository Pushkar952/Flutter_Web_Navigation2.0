import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/services/hive_storage_service.dart';
import '../core.dart';

/// AppRouterDelegate includes the parsed result from RoutesInformationParser
class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final AppRouterDelegate _instance = AppRouterDelegate._();
  bool? isLoggedIn;
  String? pathName;
  bool isError = false;

  factory AppRouterDelegate({bool? isLoggedIn}) {
    _instance.isLoggedIn = isLoggedIn;
    return _instance;
  }
  AppRouterDelegate._();

  // A custom trasition delegate to overwrite the default animation.
  TransitionDelegate transitionDelegate = CustomTransitionDelegate();

  /// Keeps the app stack
  late List<Page> _stack = [];

  /// currentConfiguration detects a route information may have changed as a result of rebuild.
  @override
  RoutePath get currentConfiguration {
    if (isError) {
      return RoutePath.unknown();
    }
    if (pathName == null) return RoutePath.home('splash'); //main

    return RoutePath.otherPage(pathName);
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey =>
      CustomNavigationKeys.navigatorKey;

  /// App Stack - Profile screen and other known and unknown routes
  List<Page> get _appStack => [
        MaterialPage(
          key: const ValueKey('home'),
          child: MainScreen(
            routeName: pathName ?? RouteData.home.name,
          ),
        )
      ];

  /// Auth route
  List<Page> get _authStack => [
        MaterialPage(
          key: const ValueKey('login'),
          child: Login(),
        ),
      ];

  /// UnKnownRoute Stack
  List<Page> get _unknownRoute => [
        const MaterialPage(
          key: ValueKey('unknown'),
          child: UnknownRoute(),
        )
      ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == true) {
      _stack = _appStack;
    } else if ((isLoggedIn == false)) {
      _stack = _authStack;
    } else {
      _stack = _unknownRoute;
    }

    return Navigator(
      transitionDelegate: transitionDelegate,
      key: navigatorKey,
      pages: _stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        pathName = null;
        // isError = false;
        notifyListeners();
        return true;
      },
    );
  }

  /// setNewRoutePath is called when a new route has been pushed to the application.
  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    bool isLoggedIn = await HiveDataStorageService.getUser();

    pathName = configuration.pathName;

    if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        if (isLoggedIn == true) {
          /// If logged in
          if (configuration.pathName == RouteData.login.name) {
            pathName = RouteData.home.name;
            isError = false;
          } else {
            pathName = configuration.pathName != RouteData.login.name
                ? configuration.pathName
                : RouteData.home.name;
            isError = false;
          }
        } else {
          pathName = RouteData.login.name;

          isError = false;
        }
      } else {
        pathName = configuration.pathName;
        isError = false;
      }
    } else {
      pathName = "/";
    }
    notifyListeners();
  }

  /// setPathName  sets url path
  void setPathName(String path, {bool loggedIn = true}) {
    pathName = path;
    isLoggedIn = loggedIn;
    setNewRoutePath(RoutePath.otherPage(pathName));
    notifyListeners();
  }
}
