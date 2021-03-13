import 'package:comedy/feacture/events_shows/data/model/get_all_events_data.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class EventShowRepository {
  Future<Either<Failure, dynamic>> createEvent();

  Future<Either<Failure, AllEventsData>> allEventDataGet();
}
