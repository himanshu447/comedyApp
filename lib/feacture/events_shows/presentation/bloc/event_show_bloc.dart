import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/feacture/events_shows/domain/usecase/create_event_usecase.dart';
import 'package:comedy/feacture/events_shows/domain/usecase/get_events_usecase.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'event_show_event.dart';

part 'event_show_state.dart';

class EventShowBloc extends Bloc<EventShowEvent, EventShowState> {
  final CreateEventUseCase createEventUseCase;
  final GetEventsUseCase getEventsUseCase;

  EventShowBloc({
    this.createEventUseCase,
    this.getEventsUseCase,
  }) : super(EventShowInitial());

  @override
  Stream<EventShowState> mapEventToState(EventShowEvent event) async* {
    if (event is GetEvents) {

      yield LoadingAllEventsState();

      var result = await getEventsUseCase(NoParams());

      yield* result.fold(
        (failure) async* {
          print(failure);
          yield ErrorState(message: (failure as Error).errMessage);
        },
        (success) async* {
          yield LoadedAllEventsState(list: success);
        },
      );

    }

    else if (event is SubmitEventAndShowsEvent) {
      yield SubmittingEventShowState();

      var result = await createEventUseCase(event.eventShowModel);

      yield* result.fold(
        (failure) async* {
          print(failure);
          yield ErrorState(message: (failure as Error).errMessage);
        },
        (success) async* {
          print(success);
          yield SubmittedEventShowState(eventShowModel: success);
        },
      );
    }
  }
}
