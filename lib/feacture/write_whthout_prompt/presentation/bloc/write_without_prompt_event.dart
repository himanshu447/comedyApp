part of 'write_without_prompt_bloc.dart';

@immutable
abstract class WriteWithoutPromptEvent {}

class SubmitPromptEvent extends WriteWithoutPromptEvent {
  final WriteWithoutPromptModel writeWithoutPromptModel;

  SubmitPromptEvent({
    this.writeWithoutPromptModel,
  });
}
