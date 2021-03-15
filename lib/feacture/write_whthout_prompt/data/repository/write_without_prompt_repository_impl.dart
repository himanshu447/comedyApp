import 'package:comedy/feacture/write_whthout_prompt/data/datasource/write_without_prompt_data_source.dart';
import 'package:comedy/feacture/write_whthout_prompt/domain/repository/write_without_prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

class WriteWithoutPromptRepositoryImpl extends WriteWithoutPromptRepository {
  final WriteWithoutPromptDataSource withoutPromptDataSource;

  WriteWithoutPromptRepositoryImpl({
    this.withoutPromptDataSource,
  });

  @override
  Future<Either<Failure, dynamic>> submitPrompt() async {
    try {
      var result = await withoutPromptDataSource.submitPrompt();
      return Right(result);
    } on PlatformException catch (e) {
      return Left(Error(errMessage: e.message));
    } catch (e) {
      return Left(Error(errMessage: e.toString()));
    }
  }
}
