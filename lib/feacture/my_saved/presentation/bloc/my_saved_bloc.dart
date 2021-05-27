import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/answer_writing_prompt/data/model/answer_write_prompt_model.dart';
import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/feacture/my_saved/domain/usecase/get_my_saved_prompt_use_case.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
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
      List<MySavedModel> searchList = [];

      mySavedList.forEach((element) {
        if (element.title != null) {
          if (element.title.containsIgnoreCase(event.text.trim())) {
            searchList.add(element);
          }
        }
        if (element.answer != null) {
          if (element.answer.containsIgnoreCase(event.text.trim()) && !searchList.contains(element) ) {
            searchList.add(element);
          }
        }
        if(element.withoutPromptDescription != null){
          if (element.withoutPromptDescription.containsIgnoreCase(event.text.trim()) && !searchList.contains(element)) {
            searchList.add(element);
          }
        }
        if(element.tags != null){
          element.tags.forEach((singleTag) {
            if (singleTag.containsIgnoreCase(event.text.trim()) && !searchList.contains(element)) {
              searchList.add(element);
            }
          });
        }

      });
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

      if (event.tags.isEmpty) {
        tempList = mySavedList;
      } else {
        event.tags.forEach((searchTag) {
          print(searchTag);

          mySavedList.forEach((saveItem) {
            if (saveItem.tags.contains('#${searchTag.toLowerCase()}') &&
                !tempList.contains(saveItem)) {
              tempList.add(saveItem);
            }
          });
        });
      }

      if (event.filters == Filters.aToz) {
        tempList.sort((a, b) => a.title.compareTo(b.title));
      } else if (event.filters == Filters.zToA) {
        tempList.sort((a, b) => b.title.compareTo(a.title));
      } else if (event.filters == Filters.newToOldDate) {
        tempList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else if (event.filters == Filters.oldToNewDate) {
        tempList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      } else if (event.filters == Filters.levelLowestToHighest) {
        tempList.sort(
            (a, b) => a.levelOfCompleteness.compareTo(b.levelOfCompleteness));
      } else if (event.filters == Filters.levelHighestToLowest) {
        tempList.sort(
            (a, b) => b.levelOfCompleteness.compareTo(a.levelOfCompleteness));
      } else if (event.filters == Filters.degreeHighestToLowest) {
        tempList.sort((a, b) => b.degreeOfNotSucking.compareTo(a.degreeOfNotSucking));
      } else if (event.filters == Filters.degreeLowestToHighest) {
        tempList.sort((a, b) => a.degreeOfNotSucking.compareTo(b.degreeOfNotSucking));
      }

      yield LoadedMySavedState(
        savedList: (state as LoadedMySavedState).savedList,
        searchSavedList: tempList,
      );
    }
    else if(event is RemoveDataFromListEvent){

      var mySavedList = (state as LoadedMySavedState).savedList;
      var mySearchList = (state as LoadedMySavedState).searchSavedList;

      if(mySearchList != null){
        if(mySearchList.isNotEmpty){
          mySearchList.removeWhere((element) => element.id == event.id);
          mySavedList.removeWhere((element) => element.id == event.id);
        }else{
          mySavedList.removeWhere((element) => element.id == event.id);
        }
      }else{
        mySavedList.removeWhere((element) => element.id == event.id);
      }

      yield LoadedMySavedState(
        savedList: mySavedList,
        searchSavedList: mySearchList,
      );

    }

    else if(event is EditAnswerWriteDataInListEvent){

      var mySavedList = (state as LoadedMySavedState).savedList;
      var mySearchList = (state as LoadedMySavedState).searchSavedList;

      List<MySavedModel> temp = [];

      if(mySearchList != null){
        if(mySearchList.isNotEmpty){
          temp = mySearchList;
        }else{
          temp = mySavedList;
        }
      }else{
        temp = mySavedList;
      }

      var changeElementIndex = temp.indexWhere((element) => element.id == event.id);

      if(changeElementIndex >=0){
        temp[changeElementIndex] = temp[changeElementIndex].copyWith(
          tags:  event.answerWritePromptModel.tags,
          title: event.answerWritePromptModel.title,
          answer: event.answerWritePromptModel.answer,
        );
      }


      if(mySearchList != null){
        if(mySearchList.isNotEmpty){
          mySearchList = temp;
        }else{
          mySavedList = temp;
        }
      }else{
        mySavedList = temp;
      }

      yield LoadedMySavedState(
        savedList: mySavedList,
        searchSavedList: mySearchList,
      );

    }

    else if(event is EditFreeWriteDataInListEvent){

      var mySavedList = (state as LoadedMySavedState).savedList;
      var mySearchList = (state as LoadedMySavedState).searchSavedList;

      List<MySavedModel> temp = [];

      if(mySearchList != null){
        if(mySearchList.isNotEmpty){
          temp = mySearchList;
        }else{
          temp = mySavedList;
        }
      }else{
        temp = mySavedList;
      }

      var changeElementIndex = temp.indexWhere((element) => element.id == event.id);

      if(changeElementIndex >=0){
        temp[changeElementIndex] = temp[changeElementIndex].copyWith(
          tags:  event.writeWithoutPromptModel.tags,
          title: event.writeWithoutPromptModel.title,
          withoutPromptDescription : event.writeWithoutPromptModel.description,
        );
      }

      if(mySearchList != null){
        if(mySearchList.isNotEmpty){
          mySearchList = temp;
        }else{
          mySavedList = temp;
        }
      }else{
        mySavedList = temp;
      }

      yield LoadedMySavedState(
        savedList: mySavedList,
        searchSavedList: mySearchList,
      );
    }
  }
}
