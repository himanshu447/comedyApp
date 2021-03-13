import 'package:comedy/feacture/events_shows/data/model/event_show_model.dart';
import 'package:comedy/feacture/events_shows/domain/repository/event_show_repository.dart';
import 'package:comedy/utils/error/failure.dart';
import 'package:comedy/utils/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class GetEventsUseCase extends UseCase<List<EventShowModel>, NoParams> {
  final EventShowRepository eventShowRepository;

  GetEventsUseCase({this.eventShowRepository});

  @override
  Future<Either<Failure, List<EventShowModel>>> call(NoParams params) {
    return eventShowRepository.getEvents();
  }
}
