import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:comedy/utils/enum_util.dart';

part 'landing_event.dart';

part 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc() : super(LandingInitialState());

  @override
  Stream<LandingState> mapEventToState(LandingEvent event) async* {
    if (event is BottomTabChangeEvent) {
      yield LoadedState(selectedTab: event.landingTab);
    }
  }
}
