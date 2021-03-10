import 'package:comedy/feacture/submit_prompt/data/model/submit_prompt_model.dart';
import 'package:comedy/share/prompt/domain/repository/prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class SubmitPromptUseCase extends UseCase<dynamic, SubmitPromptModel> {
  final PromptRepository promptRepository;

  SubmitPromptUseCase({
    this.promptRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(SubmitPromptModel params) {
    return promptRepository.submitPrompt();
  }
}
