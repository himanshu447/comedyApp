import 'package:comedy/feacture/answer_writing_prompt/data/model/question_answer_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/domain/repository/answer_writing_prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class GetQuestionsUseCase extends UseCase<List<QuestionAnswerModel>, NoParams> {
  final AnswerWritingPromptRepository answerWritingPromptRepository;

  GetQuestionsUseCase({this.answerWritingPromptRepository});

  @override
  Future<Either<Failure, List<QuestionAnswerModel>>> call(NoParams params) {
    return answerWritingPromptRepository.getQuestions();
  }
}
