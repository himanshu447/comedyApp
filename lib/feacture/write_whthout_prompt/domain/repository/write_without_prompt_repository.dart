import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';
import '';

abstract class WriteWithoutPromptRepository {
  Future<Either<Failure, WriteWithoutPromptModel>> createWriteWithoutPrompt({WriteWithoutPromptModel writeWithoutPromptModel});
  Future<Either<Failure, bool>> deleteWriteWithoutPrompt({int id});
  Future<Either<Failure, WriteWithoutPromptModel>> updateWriteWithoutPrompt({WriteWithoutPromptModel writeWithoutPromptModel});
}
