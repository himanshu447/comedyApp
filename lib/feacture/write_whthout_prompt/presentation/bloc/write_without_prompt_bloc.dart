import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/feacture/write_whthout_prompt/domain/usecase/submit_write_without_prompt_usecase.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:meta/meta.dart';

part 'write_without_prompt_event.dart';

part 'write_without_prompt_state.dart';

class WriteWithoutPromptBloc
    extends Bloc<WriteWithoutPromptEvent, WriteWithoutPromptState> {
  WriteWithoutPromptBloc({
    this.submitWriteWithoutPromptUseCase,
  }) : super(WriteWithoutPromptInitialState());

  final SubmitWriteWithoutPromptUseCase submitWriteWithoutPromptUseCase;

  @override
  Stream<WriteWithoutPromptState> mapEventToState(
      WriteWithoutPromptEvent event) async* {
    if (event is SubmitPromptEvent) {
      final failureOrSuccess = await submitWriteWithoutPromptUseCase(
        event.writeWithoutPromptModel,
      );

      yield* failureOrSuccess.fold(
        (failure) async* {
          WriteWithoutPromptErrorState(error: (failure as Error).errMessage);
        },
        (success) async* {
          WriteWithoutPromptSuccessState();
        },
      );
    }
  }
}
