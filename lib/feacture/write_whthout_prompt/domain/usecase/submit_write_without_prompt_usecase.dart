import 'package:comedy/feacture/write_whthout_prompt/data/model/write_without_prompt_model.dart';
import 'package:comedy/feacture/write_whthout_prompt/domain/repository/write_without_prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class SubmitWriteWithoutPromptUseCase
    extends UseCase<dynamic, WriteWithoutPromptModel> {
  final WriteWithoutPromptRepository withoutPromptRepository;

  SubmitWriteWithoutPromptUseCase({
    @required this.withoutPromptRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(WriteWithoutPromptModel params) {
    return withoutPromptRepository.submitPrompt();
  }
}
