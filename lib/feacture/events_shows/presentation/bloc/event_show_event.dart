part of 'event_show_bloc.dart';

@immutable
abstract class EventShowEvent {}

class GetEvents extends EventShowEvent {}

class SubmitEventAndShowsEvent extends EventShowEvent {
  final EventShowModel eventShowModel;

  SubmitEventAndShowsEvent({
    @required this.eventShowModel,
  });
}

class AddSubmittedEventInToListEvent extends EventShowEvent {
  final EventShowModel eventShowModel;

  AddSubmittedEventInToListEvent({
    @required this.eventShowModel,
  });
}

class ChangeDateForFilter extends EventShowEvent {
  final DateTime newDate;
  final int month;
  ChangeDateForFilter({this.newDate,this.month});

}
