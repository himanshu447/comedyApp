part of 'event_show_bloc.dart';

@immutable
abstract class EventShowState {
  final List<EventShowModel> eventList;

  EventShowState({
    this.eventList,
  });
}

class EventShowInitial extends EventShowState {}

class LoadingAllEventsState extends EventShowState {}

class LoadedAllEventsState extends EventShowState {
  final List<EventShowModel> list;

  LoadedAllEventsState({this.list}):super(eventList: list);
}

class SubmittingEventShowState extends EventShowState {
  final List<EventShowModel> list;

  SubmittingEventShowState({this.list}):super(eventList: list);

}

class SubmittedEventShowState extends EventShowState {
  final EventShowModel eventShowModel;
  final List<EventShowModel> list;

  SubmittedEventShowState({this.eventShowModel,this.list,}):super(eventList: list);
}

class ErrorState extends EventShowState {
  final String message;

  ErrorState({this.message});
}
