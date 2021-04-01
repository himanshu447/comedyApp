import 'package:comedy/feacture/answer_writing_prompt/data/model/answer_write_prompt_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/presentation/bloc/answer_writing_prompt_bloc.dart';

class AnswerWritingPromptDetailScreenArguments {
  final AnswerWritingPromptBloc answerWritingPromptBloc;
  final AnswerWritePromptModel answerWritePromptModel;

  AnswerWritingPromptDetailScreenArguments({
    this.answerWritingPromptBloc,
    this.answerWritePromptModel,
  });
}
