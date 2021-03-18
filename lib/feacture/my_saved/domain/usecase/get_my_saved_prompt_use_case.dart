
import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/feacture/my_saved/domain/repository/my_saved_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class GetMySavedPromptUseCase extends UseCase<List<MySavedModel>,NoParams>{

  final MySavedRepository mySavedRepository;

  GetMySavedPromptUseCase({this.mySavedRepository});

  @override
  Future<Either<Failure, List<MySavedModel>>> call(NoParams params) {
    return mySavedRepository.getMySavedPrompt();
  }
}