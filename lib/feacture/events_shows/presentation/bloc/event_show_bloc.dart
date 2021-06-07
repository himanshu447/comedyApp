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

      if(state.eventList != null){
      state.eventList.clear();
      }

      yield* result.fold(
        (failure) async* {
          print(failure);
          yield ErrorState(message: (failure as Error).errMessage);
        },
        (success) async* {
          var currentDate = DateTime.now();
          var startDate = DateTime;
            print('DATA +++++++++++++++++++++++++>$currentDate');
          success.forEach((element) {

            print(element.startDate.compareTo(
              DateTime(
                currentDate.year,
                currentDate.month,
                currentDate.day,
              ),
            ));

          });

          var todayEvents = success
              .where((element) =>
                  DateTime(element.startDate.year,element.startDate.month,element.startDate.day).compareTo(
                    DateTime(
                      currentDate.year,
                      currentDate.month,
                      currentDate.day,
                    ),
                  ) ==
                  0)
              .toList();
          yield LoadedAllEventsState(
              allList: success, dateWiseList: todayEvents);
        },
      );
    }

    else if (event is SubmitEventAndShowsEvent) {

      yield SubmittingEventShowState(list: state.eventList);

      var result = await createEventUseCase(event.eventShowModel);

      yield* result.fold(
        (failure) async* {
          print('data is failure ----->${(failure as Error).errMessage}');
          yield ErrorState(message: (failure as Error).errMessage);
        },
        (success) async* {
          yield SubmittedEventShowState(eventShowModel: success, list: state.eventList);
        },
      );
    }

    else if (event is AddSubmittedEventInToListEvent) {
      var tempList = state.eventList;

      tempList.insert(0, event.eventShowModel);

      yield LoadedAllEventsState(allList: tempList);
    }

    else if (event is ChangeDateForFilter) {

      print('-------------------->${event.newDate}');

      if(event.newDate != null){
        var todayEvents = state.eventList
            .where((element) => DateTime(element.startDate.year,element.startDate.month,element.startDate.day).compareTo(event.newDate) == 0)
            .toList();

        yield LoadedAllEventsState(allList: state.eventList, dateWiseList: todayEvents);
      }
      else{
        var todayEvents = state.eventList
            .where((element) => element.startDate.month == event.month && element.startDate.isAfter(DateTime.now()))
            .toList();

        yield LoadedAllEventsState(allList: state.eventList, dateWiseList: todayEvents);
      }
    }
  }
}
