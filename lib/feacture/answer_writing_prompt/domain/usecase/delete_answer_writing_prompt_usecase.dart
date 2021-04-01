import 'package:comedy/feacture/answer_writing_prompt/domain/repository/answer_writing_prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class DeleteAnswerWritingPromptUseCase extends UseCase<bool, IdParams>{

  final AnswerWritingPromptRepository answerWritingPromptRepository;

  DeleteAnswerWritingPromptUseCase({this.answerWritingPromptRepository});


  @override
  Future<Either<Failure, bool>> call(IdParams params) {
    return answerWritingPromptRepository.deleteAnswerWritingPrompt(id: params.id);
  }

}