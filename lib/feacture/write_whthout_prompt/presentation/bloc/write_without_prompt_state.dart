part of 'write_without_prompt_bloc.dart';

@immutable
abstract class WriteWithoutPromptState {}

class WriteWithoutPromptInitialState extends WriteWithoutPromptState {}

class WriteWithoutPromptErrorState extends WriteWithoutPromptInitialState {
  final String error;

  WriteWithoutPromptErrorState({
    this.error,
  });
}

class WriteWithoutPromptSuccessState extends WriteWithoutPromptInitialState {}
