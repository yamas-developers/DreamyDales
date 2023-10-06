
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ui/home_screen/home_screen.dart';
import '../ui/settings_screen/settings_screen.dart';
import 'animate_route.dart';
import 'route_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (BuildContext buildContext) {
        return const HomeScreen(); //splash screen
      });
    case homeScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget: const HomeScreen(),
          routeName: homeScreen);
    case settingsScreen:
      debugPrint(settings.name);
      return routeOne(
          settings: settings,
          widget: const SettingsScreen(),
          routeName: settingsScreen);
    default:
      debugPrint("default");
      return routeOne(
          settings: settings,
          widget: const HomeScreen(), //login screen
          routeName: homeScreen);
  }
}
