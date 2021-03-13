import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class EventShowRepository {
  Future<Either<Failure, EventShowModel>> createEvent(EventShowModel eventShowModel);
  Future<Either<Failure, List<EventShowModel>>> getEvents();
}
