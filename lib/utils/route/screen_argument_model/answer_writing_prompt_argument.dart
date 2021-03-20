import 'package:comedy/feacture/answer_writing_prompt/data/model/question_answer_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/presentation/bloc/answer_writing_prompt_bloc.dart';

class AnswerWritingPromptScreenArguments {
  final AnswerWritingPromptBloc answerWritingPromptBloc;
  final QuestionAnswerModel questionAnswerModel;

  AnswerWritingPromptScreenArguments({
    this.answerWritingPromptBloc,
    this.questionAnswerModel,
  });
}
