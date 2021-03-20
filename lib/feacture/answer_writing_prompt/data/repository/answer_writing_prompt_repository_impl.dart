import 'package:comedy/feacture/answer_writing_prompt/data/datasource/answer_writing_prompt_datasource.dart';
import 'package:comedy/feacture/answer_writing_prompt/data/model/question_answer_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/domain/repository/answer_writing_prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';

class AnswerWritingPromptRepositoryImpl extends AnswerWritingPromptRepository {
  final AnswerWritingPromptDataSource answerWritingPromptDataSource;

  AnswerWritingPromptRepositoryImpl({
    this.answerWritingPromptDataSource,
  });

  @override
  Future<Either<Failure, List<QuestionAnswerModel>>> getQuestions() async {
    try {
      var result = await answerWritingPromptDataSource.getQuestions();
      return Right(result);
    } catch (e) {
      return Left(Error(errMessage: e.toString()));
    }
  }
}
