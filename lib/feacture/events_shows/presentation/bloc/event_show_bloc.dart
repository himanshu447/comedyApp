import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/events_shows/domain/usecase/create_event_usecase.dart';
import 'package:meta/meta.dart';

part 'event_show_event.dart';
part 'event_show_state.dart';

class EventShowBloc extends Bloc<EventShowEvent, EventShowState> {
  CreateEventUseCase createEventUseCase;
  AllEventsDatasUseCase allEventsDatasUseCase;
  EventShowBloc({
    this.eventShowRepository,
    this.createEventUseCase,
  }) : super(EventShowInitial());

  final CreateEventUseCase createEventUseCase;
  final EventShowRepository eventShowRepository;
  @override
  Stream<EventShowState> mapEventToState(EventShowEvent event) async* {
    if (event is EventAllDataGetEvents) {
      yield LoadingBeginHomeState();
      final result = await allEventsDatasUseCase(Alleventparam());
      yield LoadingEndHomeState();

      yield result.fold((error) => ErrorState(error.message),
          (success) => EventallDataGet(allEventsData: success));
    }
    if (event is EventShowsEvents) {
      final result = await eventShowRepository.createEvent();
      if (result != null) {
        print('Successs');
      }
    }
  }

}
