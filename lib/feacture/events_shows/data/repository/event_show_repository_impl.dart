import 'package:comedy/feacture/events_shows/data/datasource/event_show_data_source.dart';
import 'package:comedy/feacture/events_shows/data/model/get_all_events_data.dart';
import 'package:comedy/feacture/events_shows/domain/repository/event_show_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

class EventShowRepositoryImpl extends EventShowRepository {
  final EventShowDataSource eventShowDataSource;

  EventShowRepositoryImpl({
    this.eventShowDataSource,
  });

  @override
  Future<Either<Failure, dynamic>> createEvent() async {
    try {
      var result = eventShowDataSource.createEvent();
      return Right(result);
    } on PlatformException catch (e) {
      return Left(Error(errMessage: (e.message)));
    } catch (e) {
      return Left(Error(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AllEventsData>> allEventDataGet() async {
    final result = await eventShowDataSource.allEventDataGet();

    print(result);
    return Right(result);
  }
}
