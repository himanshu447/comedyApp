import 'package:comedy/utils/route/route_name.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case RouteName.event_show:
        return MaterialPageRoute(builder: (_) => Container());

      default:
        return null;
    }
  }
}
