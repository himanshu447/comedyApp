import 'package:comedy/feacture/my_saved/data/datasource/my_saved_data_source.dart';
import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';
import 'package:comedy/feacture/my_saved/domain/repository/my_saved_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';

class MySavedRepositoryImpl extends MySavedRepository {
  final MySavedDataSource mySavedDataSource;

  MySavedRepositoryImpl({
    this.mySavedDataSource,
  });

  @override
  Future<Either<Failure, List<MySavedModel>>> getMySavedPrompt() async {
    try {
      var result = await mySavedDataSource.getMySavedPrompt();
      return Right(result);
    } catch (e) {
      return Left(Error(errMessage: e.toString()));
    }
  }
}
