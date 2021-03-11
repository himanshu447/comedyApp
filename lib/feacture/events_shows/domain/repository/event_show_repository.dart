import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class EventShowRepository {
  Future<Either<Failure, dynamic>> createEvent();
}
