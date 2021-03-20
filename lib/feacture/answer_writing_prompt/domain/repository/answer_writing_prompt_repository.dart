import 'package:comedy/feacture/answer_writing_prompt/data/model/question_answer_model.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AnswerWritingPromptRepository {
  Future<Either<Failure, List<QuestionAnswerModel>>> getQuestions();
}
