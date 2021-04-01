part of 'answer_writing_prompt_bloc.dart';

@immutable
abstract class AnswerWritingPromptEvent {}

class LoadQuestionsEvent extends AnswerWritingPromptEvent{}

class ChangePromptEvent extends AnswerWritingPromptEvent{}

class CreateAnswerWritePromptEvent extends AnswerWritingPromptEvent {
  final AnswerWritePromptModel answerWritePromptModel;

  CreateAnswerWritePromptEvent({
    this.answerWritePromptModel,
  });
}

class UpdateAnswerWritingPromptEvent extends AnswerWritingPromptEvent {
  final AnswerWritePromptModel answerWritePromptModel;

  UpdateAnswerWritingPromptEvent({
    this.answerWritePromptModel,
  });
}

class DeleteAnswerWritingPromptEvent extends AnswerWritingPromptEvent {
  final int id;

  DeleteAnswerWritingPromptEvent({
    this.id,
  });
}