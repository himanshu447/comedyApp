import 'package:comedy/feacture/write_whthout_prompt/domain/repository/write_without_prompt_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class DeleteWriteWithoutPromptUseCase extends UseCase<bool, IdParams>{

  final WriteWithoutPromptRepository withoutPromptRepository;

  DeleteWriteWithoutPromptUseCase({this.withoutPromptRepository});


  @override
  Future<Either<Failure, bool>> call(IdParams params) {
    return withoutPromptRepository.deleteWriteWithoutPrompt(id: params.id);
  }

}