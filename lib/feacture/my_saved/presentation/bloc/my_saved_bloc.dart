import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/feacture/my_saved/domain/usecase/get_my_saved_prompt_use_case.dart';
import 'package:comedy/utils/enum_util.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:meta/meta.dart';
import 'package:comedy/utils/extension.dart';

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
          yield LoadedMySavedState(savedList: success, searchSavedList: null);
        },
      );
    }

    else if (event is SearchMySavedEvent) {
      var mySavedList = (state as LoadedMySavedState).savedList;

      var searchList = mySavedList
          .where((element) =>
      element.title.contains(event.text.trim()) ||
          element.answer.contains(event.text.trim()))
          .toList();

      print(searchList.length);

      yield LoadedMySavedState(
        searchSavedList: searchList,
        savedList: mySavedList,
      );
    }

    else if (event is ClearSearchListEvent) {
      var mySavedList = (state as LoadedMySavedState).savedList;

      yield LoadedMySavedState(savedList: mySavedList, searchSavedList: null);
    }

    else if (event is FilterListEvent) {

      var mySavedList = (state as LoadedMySavedState).savedList;

      List<MySavedModel> tempList = [];

      if(event.tags.isEmpty){
        tempList =  mySavedList;
      }else{
        event.tags.forEach((searchTag) {
          print(searchTag);

          mySavedList.forEach((saveItem) {
            if (saveItem.tags.contains('#${searchTag.toLowerCase()}') && !tempList.contains(saveItem)) {
              tempList.add(saveItem);
            }
          });
        });
      }


      if (event.filters == Filters.aToz) {
        tempList.sort((a, b) => a.title.compareTo(b.title));
      }
      else if (event.filters == Filters.zToA) {
        tempList.sort((a, b) => b.title.compareTo(a.title));
      }
      else if (event.filters == Filters.newToOldDate) {
        tempList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
      else if (event.filters == Filters.oldToNewDate) {
        tempList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }
      else if (event.filters == Filters.levelLowestToHighest) {
        tempList.sort((a, b) =>
            a.levelOfCompleteness.compareTo(b.levelOfCompleteness));
      }
      else if (event.filters == Filters.levelHighestToLowest) {
        tempList.sort((a, b) =>
            b.levelOfCompleteness.compareTo(a.levelOfCompleteness));
      }
      else if (event.filters == Filters.degreeHighestToLowest) {
        tempList.sort((a, b) =>
            a.degreeOfNotSucking.compareTo(b.degreeOfNotSucking));
      }
      else if (event.filters == Filters.degreeLowestToHighest) {
        tempList.sort((a, b) =>
            b.degreeOfNotSucking.compareTo(a.degreeOfNotSucking));
      }


      yield LoadedMySavedState(
        savedList: (state as LoadedMySavedState).savedList,
        searchSavedList: tempList,
      );
    }
  }
}
