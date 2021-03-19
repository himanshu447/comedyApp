part of 'my_saved_bloc.dart';

@immutable
abstract class MySavedEvent {}

class LoadMySavedEvent extends MySavedEvent {}

class SearchMySavedEvent extends MySavedEvent {
  final String text;

  SearchMySavedEvent({
    this.text,
  });
}
