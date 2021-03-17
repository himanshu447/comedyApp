import 'package:comedy/feacture/submit_prompt/data/datasource/prompt_data_source.dart';
import 'package:comedy/feacture/submit_prompt/data/model/submit_prompt_model.dart';
import 'package:comedy/feacture/submit_prompt/domain/repository/prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

class PromptRepositoryImpl extends PromptRepository {
  final PromptDataSource promptDataSource;

  PromptRepositoryImpl({
    this.promptDataSource,
  });

  @override
  Future<Either<Failure, SubmitPromptModel>> submitPrompt({SubmitPromptModel submitPromptModel}) async {
    try {
      var result = await promptDataSource.submitPrompt(submitPromptModel: submitPromptModel);
      return Right(result);
    } on PlatformException catch (e) {
      return Left(Error(errMessage: e.message));
    } catch (e) {
      return Left(Error(errMessage: e.toString()));
    }
  }
}
