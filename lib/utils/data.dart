import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/core.dart';

class SubNavigationRoutes {
  String title;
  IconData icon;
  RouteData route;
  SubNavigationRoutes(
      {required this.title, required this.icon, required this.route});
}

List<SubNavigationRoutes> routeList = [
  SubNavigationRoutes(
      title: RouteData.home.name.toUpperCase(),
      icon: Icons.home,
      route: RouteData.home),
  SubNavigationRoutes(
      title: RouteData.profile.name.toUpperCase(),
      icon: Icons.person,
      route: RouteData.profile),
  SubNavigationRoutes(
      title: RouteData.settings.name.toUpperCase(),
      icon: Icons.settings,
      route: RouteData.settings),
  SubNavigationRoutes(
      title: RouteData.more.name.toUpperCase(),
      icon: Icons.more,
      route: RouteData.more),
];
