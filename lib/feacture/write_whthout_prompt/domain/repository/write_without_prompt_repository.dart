import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';
import '';

abstract class WriteWithoutPromptRepository {
  Future<Either<Failure, dynamic>> submitPrompt();
}
