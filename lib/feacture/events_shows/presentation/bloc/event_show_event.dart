part of 'event_show_bloc.dart';

@immutable
abstract class EventShowEvent {}

class GetEvents extends EventShowEvent{}

class SubmitEventAndShowsEvent extends EventShowEvent {
  final EventShowModel eventShowModel;

  SubmitEventAndShowsEvent({
    @required this.eventShowModel,
  });
}
