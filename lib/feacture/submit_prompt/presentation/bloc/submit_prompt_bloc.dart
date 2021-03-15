import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/submit_prompt/data/model/submit_prompt_model.dart';
import 'package:comedy/feacture/submit_prompt/domain/usecase/create_prompt_usecase.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:meta/meta.dart';

part 'submit_prompt_event.dart';

part 'submit_prompt_state.dart';

class SubmitPromptBloc extends Bloc<SubmitPromptEvent, SubmitPromptState> {
  SubmitPromptBloc({
    this.createPromptUseCase,
  }) : super(SubmitPromptInitial());

  final CreatePromptUseCase createPromptUseCase;

  @override
  Stream<SubmitPromptState> mapEventToState(SubmitPromptEvent event) async* {

    if (event is SubmitPromptResultEvent) {
      yield SubmitPromptLoadingState();

      final result = await createPromptUseCase(event.submitPromptModel);

      yield* result.fold(
        (failure) async* {
          yield SubmitPromptErrorState(
            errorMessage: (failure as Error).errMessage,
          );
        },
        (success) async* {
          yield SubmitPromptSuccessState();
        },
      );
    }
  }
}
