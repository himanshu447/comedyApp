import 'package:comedy/feacture/write_whthout_prompt/data/datasource/write_without_prompt_data_source.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
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
  Future<Either<Failure, WriteWithoutPromptModel>> createWriteWithoutPrompt(
      {WriteWithoutPromptModel writeWithoutPromptModel}) async {
    try {
      var result = await withoutPromptDataSource.createWriteWithoutPrompt(
          writeWithoutPromptModel: writeWithoutPromptModel);
      return Right(result);
    } on PlatformException catch (e) {
      return Left(Error(errMessage: e.message));
    } catch (e) {
      return Left(Error(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteWriteWithoutPrompt({int id}) async{
    try {
      var result = await withoutPromptDataSource.deleteWriteWithoutPrompt(id: id);
      return Right(result);
    } on PlatformException catch (e) {
      return Left(Error(errMessage: e.message));
    } catch (e) {
      return Left(Error(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WriteWithoutPromptModel>> updateWriteWithoutPrompt({WriteWithoutPromptModel writeWithoutPromptModel}) async{
    try {
      var result = await withoutPromptDataSource.updateWriteWithoutPrompt(writeWithoutPromptModel: writeWithoutPromptModel);
      return Right(result);
    } on PlatformException catch (e) {
      return Left(Error(errMessage: e.message));
    } catch (e) {
      return Left(Error(errMessage: e.toString()));
    }
  }
}
