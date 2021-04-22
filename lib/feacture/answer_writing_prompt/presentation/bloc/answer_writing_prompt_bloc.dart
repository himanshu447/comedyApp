import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/answer_writing_prompt/data/model/answer_write_prompt_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/data/model/question_answer_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/domain/usecase/create_answer_writing_prompt_usecase.dart';
import 'package:comedy/feacture/answer_writing_prompt/domain/usecase/delete_answer_writing_prompt_usecase.dart';
import 'package:comedy/feacture/answer_writing_prompt/domain/usecase/get_questions_use_case.dart';
import 'package:comedy/feacture/answer_writing_prompt/domain/usecase/update_answer_writing_prompt_usecase.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:meta/meta.dart';

part 'answer_writing_prompt_event.dart';

part 'answer_writing_prompt_state.dart';

class AnswerWritingPromptBloc
    extends Bloc<AnswerWritingPromptEvent, AnswerWritingPromptState> {
  AnswerWritingPromptBloc({
    this.getQuestionsUseCase,
    this.deleteAnswerWritingPromptUseCase,
    this.updateAnswerWritingPromptUseCase,
    this.createAnswerWritingPromptUseCase,
  }) : super(AnswerWritingPromptInitial());

  final GetQuestionsUseCase getQuestionsUseCase;
  final CreateAnswerWritingPromptUseCase createAnswerWritingPromptUseCase;
  final UpdateAnswerWritingPromptUseCase updateAnswerWritingPromptUseCase;
  final DeleteAnswerWritingPromptUseCase deleteAnswerWritingPromptUseCase;

  @override
  Stream<AnswerWritingPromptState> mapEventToState(
      AnswerWritingPromptEvent event) async* {
    if (event is LoadQuestionsEvent) {
      yield LoadingQuestionsState();

      var result = await getQuestionsUseCase(NoParams());

      yield* result.fold(
        (failure) async* {
          yield ErrorState(error: (failure as Error).errMessage);
        },
        (success) async* {
          yield LoadedQuestionsState(
              questionsList: success, questionAnswerModel: success[0]);
        },
      );
    }

    else if (event is ChangePromptEvent) {
      var list = (state as LoadedQuestionsState).questionsList;

      var question = Random().nextInt(list.length);

      yield LoadedQuestionsState(
          questionsList: list, questionAnswerModel: list[question]);
    }

    else if (event is CreateAnswerWritePromptEvent) {
      yield AnswerWritingPromptSubmittingState();

      final failureOrSuccess = await createAnswerWritingPromptUseCase(
        event.answerWritePromptModel,
      );

      yield* failureOrSuccess.fold(
        (failure) async* {
          yield ErrorState(error: (failure as Error).errMessage);
        },
        (success) async* {
          yield AnswerWritingPromptSuccessState(
              answerWritePromptModel: success);
        },
      );
    }

    else if (event is UpdateAnswerWritingPromptEvent) {
      yield AnswerWritingPromptSubmittingState();

      final failureOrSuccess = await updateAnswerWritingPromptUseCase(
        event.answerWritePromptModel,
      );

      yield* failureOrSuccess.fold(
        (failure) async* {
          yield ErrorState(error: (failure as Error).errMessage);
        },
        (success) async* {
          yield AnswerWritingPromptSuccessState(answerWritePromptModel: success);
        },
      );
    }

    else if (event is DeleteAnswerWritingPromptEvent) {
      yield DeletingAnswerWritingPromptState();

      final failureOrSuccess = await deleteAnswerWritingPromptUseCase(IdParams(
        id: event.id,
      ));

      yield* failureOrSuccess.fold(
        (failure) async* {
          yield ErrorState(error: (failure as Error).errMessage);
        },
        (success) async* {
          yield DeletedAnswerWritingPromptState(deletedPromptId: event.id);
        },
      );
    }
  }
}
