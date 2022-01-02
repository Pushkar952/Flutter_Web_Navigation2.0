import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/services/hive_storage_service.dart';
import '../core.dart';

/// AppRouterDelegate includes the parsed result from RoutesInformationParser
class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  static final AppRouterDelegate _instance = AppRouterDelegate._();
  factory AppRouterDelegate() => _instance;

  AppRouterDelegate._() {
    _init();
  }
  String? pathName;
  bool isError = false;

  bool? isLoggedIn;

  /// Keeps the app stack
  late List<Page> _stack = [];

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
        return RoutePath.otherPage(RouteData.login.name);
      }
    }
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
            key: const ValueKey('home'),
            routeName: pathName ?? RouteData.home.name,
          ),
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
          child: SplashScreen(callback: (route) {
            if (route == RouteData.login.name) {
              setPathName(route, loggedIn: false);
            } else {
              setPathName(route);
            }
          }),
        ),
      ];

  /// UnKnownRoute Stack
  List<Page> get _unknownRoute => [
        MaterialPage(
          key: ValueKey(RouteData.unkownRoute.name),
          child: const UnknownRoute(),
        )
      ];

  @override
  Widget build(BuildContext context) {
    print("isLoggedIn===> ${isLoggedIn}");
    if (pathName == null ||
        pathName == RouteData.splash.name ||
        isLoggedIn == null) {
      _stack = _splashStack;
    } else if (isLoggedIn != null && isLoggedIn == true) {
      _stack = _appStack;
    } else if (pathName == RouteData.login.name &&
        (isLoggedIn != null && isLoggedIn == false)) {
      _stack = _authStack;
    } else {
      _stack = _unknownRoute;
    }

    return Navigator(
      key: navigatorKey,
      pages: _stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        isError = false;
        notifyListeners();
        return true;
      },
    );
  }

  /// setNewRoutePath is called when a new route has been pushed to the application.
  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    pathName = configuration.pathName;
    // notifyListeners();

    if (configuration.isOtherPage) {
      if (configuration.pathName != null) {
        if (isLoggedIn == true) {
          /// If logged in
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
        pathName = configuration.pathName;
        isError = true;
        notifyListeners();
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
    setNewRoutePath(RoutePath.otherPage(pathName));

    isLoggedIn = loggedIn;
    notifyListeners();
  }

  /// Initializing router delegate to handle login status
  _init() async {
    String _user = await HiveDataStorageService.getUser();
    if (_user.isNotEmpty) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }

    if (_user.isNotEmpty) {
      pathName = RouteData.home.name;
      isError = false;
    } else if (isLoggedIn == null) {
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
