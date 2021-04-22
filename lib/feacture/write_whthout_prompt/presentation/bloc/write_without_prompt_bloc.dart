import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/feacture/write_whthout_prompt/domain/usecase/create_write_without_prompt_usecase.dart';
import 'package:comedy/feacture/write_whthout_prompt/domain/usecase/delete_write_without_prompt_usecase.dart';
import 'package:comedy/feacture/write_whthout_prompt/domain/usecase/update_write_without_prompt_usecase.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:meta/meta.dart';

part 'write_without_prompt_event.dart';

part 'write_without_prompt_state.dart';

class WriteWithoutPromptBloc
    extends Bloc<WriteWithoutPromptEvent, WriteWithoutPromptState> {
  WriteWithoutPromptBloc({
    this.createWriteWithoutPromptUseCase,
    this.deleteWriteWithoutPromptUseCase,
    this.updateWriteWithoutPromptUseCase,
  }) : super(WriteWithoutPromptInitialState());

  final CreateWriteWithoutPromptUseCase createWriteWithoutPromptUseCase;
  final DeleteWriteWithoutPromptUseCase deleteWriteWithoutPromptUseCase;
  final UpdateWriteWithoutPromptUseCase updateWriteWithoutPromptUseCase;

  @override
  Stream<WriteWithoutPromptState> mapEventToState(
      WriteWithoutPromptEvent event) async* {

    if (event is CreateWriteWithoutPromptEvent) {
      yield WriteWithoutPromptSubmittingState();

      final failureOrSuccess = await createWriteWithoutPromptUseCase(
        event.writeWithoutPromptModel,
      );

      yield* failureOrSuccess.fold(
        (failure) async* {
          yield WriteWithoutPromptErrorState(
              error: (failure as Error).errMessage);
        },
        (success) async* {
          yield WriteWithoutPromptSuccessState(
              writeWithoutPromptModel: success);
        },
      );
    }

    else if (event is UpdateWriteWithoutPromptEvent) {
      yield WriteWithoutPromptSubmittingState();

      final failureOrSuccess = await updateWriteWithoutPromptUseCase(
        event.writeWithoutPromptModel,
      );

      yield* failureOrSuccess.fold(
        (failure) async* {
          yield WriteWithoutPromptErrorState(error: (failure as Error).errMessage);
        },
        (success) async* {
          yield WriteWithoutPromptSuccessState(writeWithoutPromptModel: success);
        },
      );
    }

    else if (event is DeleteWriteWithoutPromptEvent) {

      print('event call during up');
      yield DeletingWriteWithoutPromptState();
      print('event call during up');


      final failureOrSuccess = await deleteWriteWithoutPromptUseCase(IdParams(
        id: event.id,
      ));

      yield* failureOrSuccess.fold(
        (failure) async* {
          yield WriteWithoutPromptErrorState(error: (failure as Error).errMessage);
        },
        (success) async* {
          yield DeletedWriteWithoutPromptState(deletedPromptId: event.id);
        },
      );
    }
  }
}
