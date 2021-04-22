part of 'write_without_prompt_bloc.dart';

@immutable
abstract class WriteWithoutPromptState {}

class WriteWithoutPromptInitialState extends WriteWithoutPromptState {}

class WriteWithoutPromptSubmittingState extends WriteWithoutPromptState {}

class WriteWithoutPromptErrorState extends WriteWithoutPromptState {
  final String error;

  WriteWithoutPromptErrorState({
    this.error,
  });
}

class WriteWithoutPromptSuccessState extends WriteWithoutPromptState {
  final WriteWithoutPromptModel writeWithoutPromptModel;

  WriteWithoutPromptSuccessState({
    this.writeWithoutPromptModel,
  });
}

class DeletingWriteWithoutPromptState extends WriteWithoutPromptState {}

class DeletedWriteWithoutPromptState extends WriteWithoutPromptState {
  final int deletedPromptId;

  DeletedWriteWithoutPromptState({
    this.deletedPromptId,
  });
}
