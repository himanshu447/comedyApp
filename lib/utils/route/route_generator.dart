import 'package:comedy/feacture/about/presentation/page/about_us.dart';
import 'package:comedy/feacture/answer_writing_prompt/presentation/page/answer_wiriting_prompt.dart';
import 'package:comedy/feacture/answer_writing_prompt/presentation/page/answer_writing_prompt_detail.dart';
import 'package:comedy/feacture/events_shows/presentation/page/event_detail.dart';
import 'package:comedy/feacture/events_shows/presentation/page/events_shows.dart';
import 'package:comedy/feacture/events_shows/presentation/page/submit_events.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/feacture/write_whthout_prompt/presentation/page/write_without_prompt.dart';
import 'package:comedy/feacture/write_whthout_prompt/presentation/page/write_without_prompt_detail.dart';
import 'package:comedy/utils/route/route_name.dart';
import 'package:comedy/utils/route/screen_argument_model/answer_writing_prompt_argument.dart';
import 'package:comedy/utils/route/screen_argument_model/answer_writing_prompt_detail_arguments.dart';
import 'package:comedy/utils/route/screen_argument_model/write_without_prompt_detail_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.event_show:
        return MaterialPageRoute(
          builder: (_) => EventsShows(),
        );
      case RouteName.event_detail:
        return MaterialPageRoute(
          builder: (_) => EventDetail(
            eventShowModel: routeSettings.arguments,
          ),
        );

      case RouteName.submit_event:
        return MaterialPageRoute(builder: (_) => SubmitEvents());

      case RouteName.write_without_prompt:
        return MaterialPageRoute(
          builder: (_) => WriteWithoutPromptView(),
        );

      case RouteName.write_without_prompt_detail:
        WriteWithoutPromptDetailScreenArguments args = routeSettings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: args.withoutPromptBloc,
            child: WriteWithoutPromptDetailView(
              withoutPromptModel: args.writeWithoutPromptModel,
            ),
          ),
        );

      case RouteName.answer_writing_prompt:
        AnswerWritingPromptScreenArguments args = routeSettings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: args.answerWritingPromptBloc,
            child: AnswerWritingPromptView(
              questionAnswerModel: args.questionAnswerModel,
            ),
          ),
        );

      case RouteName.answer_writing_prompt_detail:
        AnswerWritingPromptDetailScreenArguments args = routeSettings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: args.answerWritingPromptBloc,
            child: AnswerWritingPromptDetailView(
              answerWritePromptModel: args.answerWritePromptModel,
            ),
          ),
        );

      case RouteName.about_us:
        return MaterialPageRoute(
          builder: (_) => AboutUsView(),
        );
        return MaterialPageRoute(builder: (_) => EventsShows());

      default:
        return null;
    }
  }
}
