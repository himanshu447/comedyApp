part of 'landing_bloc.dart';

abstract class LandingEvent {}

class BottomTabChangeEvent extends LandingEvent {
  final LandingTab landingTab;

  BottomTabChangeEvent({this.landingTab});
}
