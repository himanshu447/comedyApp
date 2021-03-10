import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PromptRepository {
  Future<Either<Failure,dynamic>> submitPrompt();
}
