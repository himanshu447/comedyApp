import 'package:comedy/feacture/events_shows/presentation/page/event_detail.dart';
import 'package:comedy/feacture/events_shows/presentation/page/events_shows.dart';
import 'package:comedy/feacture/events_shows/presentation/page/submit_events.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/feacture/write_whthout_prompt/presentation/page/write_without_prompt.dart';
import 'package:comedy/feacture/write_whthout_prompt/presentation/page/write_without_prompt_detail.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {

    switch (routeSettings.name) {
      case RouteName.event_show:
        return MaterialPageRoute(
          builder: (_) => EventsShows(),
        );
      case RouteName.event_detail:
        return MaterialPageRoute(builder: (_) => EventDetail());

      case RouteName.submit_event:
        return MaterialPageRoute(builder: (_) => SubmitEvents());

      case RouteName.write_without_prompt:
        return MaterialPageRoute(
          builder: (_) => WriteWithoutPromptView(),
        );

      case RouteName.write_without_prompt_detail:
        WriteWithoutPromptModel args = routeSettings.arguments;
        return MaterialPageRoute(
          builder: (_) => WriteWithoutPromptDetailView(
            withoutPromptModel: args,
          ),
        );
        return MaterialPageRoute(builder: (_) => EventsShows());

      default:
        return null;
    }
  }
}
