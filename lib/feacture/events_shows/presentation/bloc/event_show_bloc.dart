import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/events_shows/domain/usecase/create_event_usecase.dart';
import 'package:meta/meta.dart';

part 'event_show_event.dart';

part 'event_show_state.dart';

class EventShowBloc extends Bloc<EventShowEvent, EventShowState> {
  EventShowBloc({
    this.createEventUseCase,
  }) : super(EventShowInitial());

  final CreateEventUseCase createEventUseCase;

  @override
  Stream<EventShowState> mapEventToState(EventShowEvent event) async* {

  }

}
