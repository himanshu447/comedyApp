import 'package:comedy/feacture/submit_prompt/data/model/submit_prompt_model.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PromptRepository {
  Future<Either<Failure,SubmitPromptModel>> submitPrompt(
      {SubmitPromptModel submitPromptModel});
}
