import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/feacture/events_shows/data/model/get_all_events_data.dart';
import 'package:comedy/feacture/events_shows/domain/repository/event_show_repository.dart';
import 'package:comedy/feacture/events_shows/domain/usecase/create_event_usecase.dart';
import 'package:meta/meta.dart';

part 'event_show_event.dart';
part 'event_show_state.dart';

class EventShowBloc extends Bloc<EventShowEvent, EventShowState> {
  EventShowBloc({
    this.eventShowRepository,
    this.createEventUseCase,
  }) : super(EventShowInitial());

  final CreateEventUseCase createEventUseCase;
  final EventShowRepository eventShowRepository;
  @override
  Stream<EventShowState> mapEventToState(EventShowEvent event) async* {
    if (event is EventShowsEvents) {
      final result = await eventShowRepository.createEvent();
      if (result != null) {
        print('Successs');
      }
    }
  }
}
