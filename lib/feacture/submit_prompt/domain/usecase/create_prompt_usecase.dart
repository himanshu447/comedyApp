import 'package:comedy/feacture/submit_prompt/data/model/submit_prompt_model.dart';
import 'package:comedy/feacture/submit_prompt/domain/repository/prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class CreatePromptUseCase extends UseCase<SubmitPromptModel, SubmitPromptModel> {
  final PromptRepository promptRepository;

  CreatePromptUseCase({
    this.promptRepository,
  });

  @override
  Future<Either<Failure, SubmitPromptModel>> call(SubmitPromptModel params) {
    return promptRepository.submitPrompt(submitPromptModel: params);
  }
}
