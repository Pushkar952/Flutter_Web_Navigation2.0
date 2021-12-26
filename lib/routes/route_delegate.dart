import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/services/hive_storage_service.dart';
import '../core.dart';

/// AppRouterDelegate includes the parsed result from RoutesInformationParser
class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final AppRouterDelegate _instance = AppRouterDelegate._();

  String? pathName;
  bool isError = false;

  bool? isLoggedIn;

  /// Keeps the app stack
  late List<Page> _stack = [];
  factory AppRouterDelegate() => _instance;

  AppRouterDelegate._() {
    _init();
  }

  /// currentConfiguration detects a route information may have changed as a result of rebuild.
  @override
  RoutePath get currentConfiguration {
    if (isError) {
      return RoutePath.unknown();
    }

    if (pathName == null) {
      if (isLoggedIn == null) {
        return RoutePath.otherPage(RouteData.splash.name);
      } else if (isLoggedIn == true) {
        if (pathName == "/") return RoutePath.home(pathName);
        return RoutePath.otherPage(pathName);
      } else {
        return RoutePath.home(RouteData.login.name);
      }
    }

    return RoutePath.otherPage(pathName);
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey =>
      CustomNavigationKeys.navigatorKey;

  /// App Stack - Login and other screens
  List<Page> get _appStack => [
        (isLoggedIn == true)
            ? MaterialPage(
                key: ValueKey(RouteData.home.name),
                child: HomeScreen(
                  key: ValueKey('$pathName'),
                ),
              )
            : MaterialPage(
                key: ValueKey(RouteData.login.name),
                child: Login(
                  key: ValueKey('$pathName'),
                ),
              ),
        if (pathName == RouteData.unkownRoute.name)
          MaterialPage(
            key: ValueKey(RouteData.unkownRoute.name),
            child: const UnknownRoute(),
          )
      ];

  /// Splash stack
  List<Page> get _splashStack => [
        MaterialPage(
          key: ValueKey(RouteData.splash.name),
          child: const SplashScreen(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    if (pathName == null) {
      _stack = _splashStack;
    } else {
      _stack = _appStack;
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

  /// Set login status
  /// - [true] - logged in
  /// - [false] - logged out
  void loggedIn(value) {
    isLoggedIn = value;

    if (isLoggedIn == null) {
      pathName = RouteData.unkownRoute.name;
      isError = true;
    } else if (isLoggedIn == false) {
      pathName = RouteData.login.name;
      isError = false;
    } else {
      pathName = RouteData.home.name;
      isError = false;
    }

    notifyListeners();
  }

  /// setNewRoutePath is called when a new route has been pushed to the application.
  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    isLoggedIn ??= false;
    if (configuration.isUnknown) {
      isLoggedIn = false;
      isError = true;
      return;
    }

    if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        if (isLoggedIn == true) {
          if (configuration.pathName == RouteData.login.name) {
            pathName = RouteData.home.name;
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

  /// This function sets url path
  void setPathName(String path, {bool loggedIn = true}) {
    pathName = path;
    isLoggedIn = loggedIn;
    notifyListeners();
  }

  /// Initializing router delegate to handle login status
  _init() async {
    isLoggedIn = await HiveDataStorageService.getUser();

    if (isLoggedIn == null) {
      pathName = RouteData.unkownRoute.name;
      isError = true;
    } else if (isLoggedIn == false) {
      pathName = RouteData.login.name;
      isError = false;
    } else if (pathName == null || pathName!.isEmpty) {
      pathName = RouteData.home.name;
      isError = false;
    }
    notifyListeners();
  }
}
