part of 'write_without_prompt_bloc.dart';

@immutable
abstract class WriteWithoutPromptEvent {}

class CreateWriteWithoutPromptEvent extends WriteWithoutPromptEvent {
  final WriteWithoutPromptModel writeWithoutPromptModel;

  CreateWriteWithoutPromptEvent({
    this.writeWithoutPromptModel,
  });
}

class UpdateWriteWithoutPromptEvent extends WriteWithoutPromptEvent {
  final WriteWithoutPromptModel writeWithoutPromptModel;

  UpdateWriteWithoutPromptEvent({
    this.writeWithoutPromptModel,
  });
}

class DeleteWriteWithoutPromptEvent extends WriteWithoutPromptEvent {
  final int id;

  DeleteWriteWithoutPromptEvent({
    this.id,
  });
}