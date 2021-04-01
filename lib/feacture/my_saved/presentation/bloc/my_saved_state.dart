part of 'my_saved_bloc.dart';

@immutable
abstract class MySavedState {}

class MySavedInitial extends MySavedState {}

class LoadingMySavedState extends MySavedState {}

class LoadedMySavedState extends MySavedState {
  final List<MySavedModel> savedList;
  final List<MySavedModel> searchSavedList;

  LoadedMySavedState({
    this.savedList,
    this.searchSavedList
  });
}

class ErrorMySavedState extends MySavedState {
  final String message;

  ErrorMySavedState({
    this.message,
  });
}
