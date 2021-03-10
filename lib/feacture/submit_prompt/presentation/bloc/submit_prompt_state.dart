part of 'submit_prompt_bloc.dart';

@immutable
abstract class SubmitPromptState {}

class SubmitPromptInitial extends SubmitPromptState {}

class SubmitPromptLoadingState extends SubmitPromptState{}

class SubmitPromptErrorState extends SubmitPromptState {
  final String errorMessage;

  SubmitPromptErrorState({
    this.errorMessage,
  });
}

class SubmitPromptSuccessState extends SubmitPromptState {}
