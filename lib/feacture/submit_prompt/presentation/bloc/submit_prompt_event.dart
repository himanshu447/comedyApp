part of 'submit_prompt_bloc.dart';

@immutable
abstract class SubmitPromptEvent {}

class SubmitPromptResultEvent extends SubmitPromptEvent {
  final SubmitPromptModel submitPromptModel;

  SubmitPromptResultEvent({
    this.submitPromptModel,
  });
}
