part of 'answer_writing_prompt_bloc.dart';

@immutable
abstract class AnswerWritingPromptEvent {}

class LoadQuestionsEvent extends AnswerWritingPromptEvent{}

class ChangePromptEvent extends AnswerWritingPromptEvent{}
