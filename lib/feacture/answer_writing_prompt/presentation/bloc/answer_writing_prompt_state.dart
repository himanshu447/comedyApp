part of 'answer_writing_prompt_bloc.dart';

@immutable
abstract class AnswerWritingPromptState {}

class AnswerWritingPromptInitial extends AnswerWritingPromptState {}

class LoadingQuestionsState extends AnswerWritingPromptState {}

class LoadedQuestionsState extends AnswerWritingPromptState {
  final List<QuestionAnswerModel> questionsList;
  final QuestionAnswerModel questionAnswerModel;

  LoadedQuestionsState({
    this.questionsList,
    this.questionAnswerModel,
  });
}

class SingleQuestionState extends AnswerWritingPromptState{
  final QuestionAnswerModel questionAnswerModel;

  SingleQuestionState({this.questionAnswerModel});

}

class ErrorState extends AnswerWritingPromptState {
  final String error;

  ErrorState({
    this.error,
  });
}

class AnswerWritingPromptSubmittingState extends AnswerWritingPromptState {}

class AnswerWritingPromptSuccessState extends AnswerWritingPromptState {
  final AnswerWritePromptModel answerWritePromptModel;

  AnswerWritingPromptSuccessState({
    this.answerWritePromptModel,
  });
}

class DeletingAnswerWritingPromptState extends AnswerWritingPromptState {}

class DeletedAnswerWritingPromptState extends AnswerWritingPromptState {}