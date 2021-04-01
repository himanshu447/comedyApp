import 'package:comedy/feacture/answer_writing_prompt/data/model/answer_write_prompt_model.dart';
import 'package:comedy/feacture/answer_writing_prompt/domain/repository/answer_writing_prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class UpdateAnswerWritingPromptUseCase
    extends UseCase<AnswerWritePromptModel, AnswerWritePromptModel> {
  final AnswerWritingPromptRepository answerWritingPromptRepository;

  UpdateAnswerWritingPromptUseCase({
    @required this.answerWritingPromptRepository,
  });

  @override
  Future<Either<Failure, AnswerWritePromptModel>> call(
      AnswerWritePromptModel params) {
    return answerWritingPromptRepository.updateAnswerWritingPrompt(
        answerWritePromptModel: params);
  }
}
