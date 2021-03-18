import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:comedy/feacture/my_saved/data/model/my_saved_model.dart';

abstract class MySavedRepository {
  Future<Either<Failure, List<MySavedModel>>> getMySavedPrompt();
}