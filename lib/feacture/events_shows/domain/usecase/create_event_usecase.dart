import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/feacture/events_shows/data/model/get_all_events_data.dart';
import 'package:comedy/feacture/events_shows/domain/repository/event_show_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateEventUseCase extends UseCase<dynamic, EventShowModel> {
  final EventShowRepository eventShowRepository;

  CreateEventUseCase({
    this.eventShowRepository,
  });

  @override
  Future<Either<Failure, dynamic>> call(EventShowModel params) {
    return eventShowRepository.createEvent();
  }
}

class AllEventsDatasUseCase extends UseCase<AllEventsData, Alleventparam> {
  EventShowRepository eventShowRepository;

  AllEventsDatasUseCase({
    this.eventShowRepository,
  });
  @override
  Future<Either<Failure, AllEventsData>> call(Alleventparam param) async {
    return await eventShowRepository.allEventDataGet();
  }
}

class Alleventparam extends Equatable {
  @override
  List<Object> get props => [];
}
