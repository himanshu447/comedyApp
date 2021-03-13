part of 'event_show_bloc.dart';

@immutable
abstract class EventShowEvent {}

class EventShowsEvents extends EventShowEvent {
  EventShowsEvents();
}

class EventAllDataGetEvents extends EventShowEvent {
  List<Object> get props => null;
}
