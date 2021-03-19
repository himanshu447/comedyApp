import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/feacture/my_saved/domain/usecase/get_my_saved_prompt_use_case.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:meta/meta.dart';

part 'my_saved_event.dart';

part 'my_saved_state.dart';

class MySavedBloc extends Bloc<MySavedEvent, MySavedState> {
  MySavedBloc({
    this.getMySavedPromptUseCase,
  }) : super(MySavedInitial());

  final GetMySavedPromptUseCase getMySavedPromptUseCase;

  @override
  Stream<MySavedState> mapEventToState(MySavedEvent event) async* {
    if (event is LoadMySavedEvent) {
      yield LoadingMySavedState();

      var result = await getMySavedPromptUseCase(NoParams());

      yield* result.fold(
        (failure) async* {
          yield ErrorMySavedState(message: (failure as Error).errMessage);
        },
        (success) async* {
          yield LoadedMySavedState(savedList: success);
        },
      );
    } else if (event is SearchMySavedEvent) {
      var text = event.text.trim().toUpperCase();

      var mySavedList = (state as LoadedMySavedState).savedList;

      var searchList = mySavedList
          .where((element) =>
              element.title.contains(text) || element.answer.contains(text))
          .toList();

      print(searchList.length);

      yield LoadedMySavedState(
        searchSavedList: searchList,
        savedList: mySavedList,
      );
    }
  }
}
