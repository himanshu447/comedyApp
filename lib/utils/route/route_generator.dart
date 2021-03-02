import 'package:comedy/feacture/events_shows/presentation/page/event_detail.dart';
import 'package:comedy/feacture/events_shows/presentation/page/events_shows.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case RouteName.event_show:
        return MaterialPageRoute(builder: (_) => EventsShows());
      case RouteName.event_detail:
        return MaterialPageRoute(builder: (_) => EventDetail());

      default:
        return null;
    }
  }
}
