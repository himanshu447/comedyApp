part of 'landing_bloc.dart';

abstract class LandingState {}

class LandingInitialState extends LandingState {
}

class LoadedState extends LandingState {
  final LandingTab selectedTab;

  LoadedState({this.selectedTab});
}
