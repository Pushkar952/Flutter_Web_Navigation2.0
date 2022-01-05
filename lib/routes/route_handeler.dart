import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/screens/home_screen.dart';
import 'package:flutter_web_navigation/screens/more.dart';
import 'package:flutter_web_navigation/screens/profile_screen.dart';
import 'package:flutter_web_navigation/screens/settings_screen.dart';
import 'package:flutter_web_navigation/screens/unknown.dart';

enum RouteData {
  /// For routes for which we want to show unkown page that are not being parsed
  unkownRoute,

  /// For routes that are parsed but not data is found for them eg. /user/?userName=abc and abc doesnt exist
  notFound,

  profile,
  login,
  home,
  more,
  settings
}

/// Class to handle route path related informations
class RouteHandeler {
  static final RouteHandeler _instance = RouteHandeler._();
  factory RouteHandeler() => _instance;
  RouteHandeler._();

  /// Returns [WidgetToRender, PathName]
  /// [WidgetToRender] - Renders specified widget
  /// [PathName] - Re-directs to [PathName] if invalid path is entered
  Widget getRouteWidget(String? routeName) {
    RouteData routeData;

    if (routeName != null) {
      final uri = Uri.parse(routeName);

      if (uri.pathSegments.isNotEmpty) {
        /// Getting first endpoint
        final pathName = uri.pathSegments.elementAt(0).toString();

        /// Getting route data for specified pathName
        routeData = RouteData.values.firstWhere(
            (element) => element.name == pathName,
            orElse: () => RouteData.notFound);

        if (routeData != RouteData.notFound) {
          switch (routeData) {
            case RouteData.home:
              return Home(
                routeName: routeName,
              );

            case RouteData.profile:
              return Profile(
                routeName: routeName,
              );

            case RouteData.settings:
              return Settings(
                routeName: routeName,
              );

            case RouteData.more:
              return More(
                routeName: routeName,
              );

            default:
              return Home(
                routeName: routeName,
              );
          }
        } else {
          return const UnknownRoute();
        }
      } else {
        return Home(
          routeName: routeName,
        );
      }
    } else {
      return const UnknownRoute();
    }
  }
}
