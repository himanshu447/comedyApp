part of 'event_show_bloc.dart';

@immutable
abstract class EventShowState {}

class EventShowInitial extends EventShowState {}

class LoadingBeginHomeState extends EventShowState {}

class LoadingEndHomeState extends EventShowState {}

class EventsuccessState extends EventShowState {
  EventShowModel eventShowModel;
  EventsuccessState(this.eventShowModel);
}

class ErrorState extends EventShowState {
  final String message;
  ErrorState(this.message);
}

class EventallDataGet extends EventShowState {
  AllEventsData allEventsData;

  EventallDataGet({this.allEventsData});
}
