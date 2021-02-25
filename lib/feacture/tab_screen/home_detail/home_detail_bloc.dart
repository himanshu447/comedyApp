import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_detail_event.dart';
part 'home_detail_state.dart';

class HomeDetailBloc extends Bloc<HomeDetailEvent, HomeDetailState> {
  HomeDetailBloc() : super(HomeDetailInitial());

  @override
  Stream<HomeDetailState> mapEventToState(
    HomeDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
