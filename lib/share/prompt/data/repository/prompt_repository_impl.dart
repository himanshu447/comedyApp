import 'package:comedy/share/prompt/data/datasource/prompt_datasource.dart';
import 'package:comedy/share/prompt/domain/repository/prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

class PromptRepositoryImpl extends PromptRepository {
  final PromptDataSource promptDataSource;

  PromptRepositoryImpl({
    this.promptDataSource,
  });

  @override
  Future<Either<Failure, dynamic>> submitPrompt() async {
    try {
      var result = promptDataSource.submitPrompt();
      return Right(result);
    } on PlatformException catch (e) {
      return Left(Error(errMessage: e.message));
    } catch (e) {
      return Left(Error(errMessage: e.toString()));
    }
  }
}
