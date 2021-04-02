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

class ClearSearchListEvent extends MySavedEvent {}

class FilterListEvent extends MySavedEvent {
  final Filters filters;
  final List<String> tags;

  FilterListEvent({
    this.filters,
    this.tags = const [],
  });
}
