import 'package:comedy/feacture/answer_writing_prompt/data/datasource/answer_writing_prompt_datasource.dart';
import 'package:comedy/feacture/answer_writing_prompt/data/repository/answer_writing_prompt_repository_impl.dart';
import 'package:comedy/feacture/events_shows/data/datasource/event_show_data_source.dart';
import 'package:comedy/feacture/events_shows/domain/repository/event_show_repository.dart';
import 'package:comedy/feacture/events_shows/domain/usecase/create_event_usecase.dart';
import 'package:comedy/feacture/events_shows/domain/usecase/get_events_usecase.dart';
import 'package:comedy/feacture/events_shows/presentation/bloc/event_show_bloc.dart';
import 'package:comedy/feacture/my_saved/data/datasource/my_saved_data_source.dart';
import 'package:comedy/feacture/my_saved/data/repository/my_saved_repository_impl.dart';
import 'package:comedy/feacture/my_saved/domain/repository/my_saved_repository.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/datasource/write_without_prompt_data_source.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/repository/write_without_prompt_repository_impl.dart';
import 'package:comedy/feacture/write_whthout_prompt/domain/usecase/delete_write_without_prompt_usecase.dart';
import 'package:comedy/feacture/write_whthout_prompt/domain/usecase/update_write_without_prompt_usecase.dart';
import 'package:comedy/feacture/write_whthout_prompt/presentation/bloc/write_without_prompt_bloc.dart';
import 'package:comedy/share/data/datasource/save_prompt_data_source.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:device_info/device_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'feacture/answer_writing_prompt/domain/repository/answer_writing_prompt_repository.dart';
import 'feacture/answer_writing_prompt/domain/usecase/get_questions_use_case.dart';
import 'feacture/answer_writing_prompt/presentation/bloc/answer_writing_prompt_bloc.dart';
import 'feacture/events_shows/data/repository/event_show_repository_impl.dart';
import 'feacture/landing/presentation/bloc/landing_bloc.dart';
import 'feacture/my_saved/domain/usecase/get_my_saved_prompt_use_case.dart';
import 'feacture/my_saved/presentation/bloc/my_saved_bloc.dart';
import 'feacture/submit_prompt/data/datasource/prompt_data_source.dart';
import 'feacture/submit_prompt/data/repository/prompt_repository_impl.dart';
import 'feacture/submit_prompt/domain/repository/prompt_repository.dart';
import 'feacture/submit_prompt/domain/usecase/create_prompt_usecase.dart';
import 'feacture/submit_prompt/presentation/bloc/submit_prompt_bloc.dart';
import 'feacture/write_whthout_prompt/domain/repository/write_without_prompt_repository.dart';
import 'feacture/write_whthout_prompt/domain/usecase/create_write_without_prompt_usecase.dart';

final injector = GetIt.instance;

Future init() async {
  ///External
  injector.registerLazySingleton(() => http.Client());
  injector.registerLazySingleton(() => WebService());
  injector.registerLazySingleton(() => DeviceInfoPlugin());

  injector.registerLazySingleton<SavePromptDataSource>(
    () => SavePromptDataSourceImpl(
      webService: injector(),
      deviceInfoPlugin: injector(),
    ),
  );

  ///Landing Bloc
  injector.registerFactory(() => LandingBloc());

  ///Write without prompt
  _writeWithoutPrompt();

  ///Write without prompt
  _submitPrompt();

  ///Event and shows
  _eventShows();

  ///My Saved
  _mySaved();

  ///Answer Writing Prompt
  _answerWritingPrompt();
}

void _eventShows() {
  //bloc
  injector.registerFactory(
    () => EventShowBloc(
      createEventUseCase: injector(),
      getEventsUseCase: injector(),
    ),
  );

  //useCase
  injector.registerLazySingleton(
    () => CreateEventUseCase(
      eventShowRepository: injector(),
    ),
  );
  injector.registerLazySingleton(
    () => GetEventsUseCase(
      eventShowRepository: injector(),
    ),
  );

  //repository
  injector.registerLazySingleton<EventShowRepository>(
    () => EventShowRepositoryImpl(
      eventShowDataSource: injector(),
    ),
  );

  //dataSource
  injector.registerLazySingleton<EventShowDataSource>(
    () => EventShowDataSourceImpl(
      webService: injector(),
    ),
  );
}

void _writeWithoutPrompt() {
  //bloc
  injector.registerFactory(
    () => WriteWithoutPromptBloc(
      createWriteWithoutPromptUseCase: injector(),
      deleteWriteWithoutPromptUseCase: injector(),
      updateWriteWithoutPromptUseCase: injector(),
    ),
  );

  //useCase
  injector.registerLazySingleton(
    () => CreateWriteWithoutPromptUseCase(
      withoutPromptRepository: injector(),
    ),
  );
  injector.registerLazySingleton(
    () => DeleteWriteWithoutPromptUseCase(
      withoutPromptRepository: injector(),
    ),
  );
  injector.registerLazySingleton(
    () => UpdateWriteWithoutPromptUseCase(
      withoutPromptRepository: injector(),
    ),
  );

  //repository
  injector.registerLazySingleton<WriteWithoutPromptRepository>(
    () => WriteWithoutPromptRepositoryImpl(
      withoutPromptDataSource: injector(),
    ),
  );

  //dataSource
  injector.registerLazySingleton<WriteWithoutPromptDataSource>(
    () => WriteWithoutPromptDataSourceImpl(
      webService: injector(),
      savePromptDataSource: injector(),
    ),
  );
}

void _submitPrompt() {
  //bloc
  injector
      .registerFactory(() => SubmitPromptBloc(createPromptUseCase: injector()));

  //useCase
  injector.registerLazySingleton(
    () => CreatePromptUseCase(
      promptRepository: injector(),
    ),
  );

  //repository
  injector.registerLazySingleton<PromptRepository>(
    () => PromptRepositoryImpl(
      promptDataSource: injector(),
    ),
  );

  //dataSource
  injector.registerLazySingleton<PromptDataSource>(
    () => PromptDataSourceImpl(
      webService: injector(),
    ),
  );
}

void _mySaved() {
  //bloc
  injector
      .registerFactory(() => MySavedBloc(getMySavedPromptUseCase: injector()));

  //useCase
  injector.registerLazySingleton(
    () => GetMySavedPromptUseCase(
      mySavedRepository: injector(),
    ),
  );

  //repository
  injector.registerLazySingleton<MySavedRepository>(
    () => MySavedRepositoryImpl(
      mySavedDataSource: injector(),
    ),
  );

  //dataSource
  injector.registerLazySingleton<MySavedDataSource>(
    () => MySavedDataSourceImpl(
      webService: injector(),
      deviceInfoPlugin: injector(),
    ),
  );
}

void _answerWritingPrompt() {
  //bloc
  injector.registerFactory(
      () => AnswerWritingPromptBloc(getQuestionsUseCase: injector()));

  //useCase
  injector.registerLazySingleton(
    () => GetQuestionsUseCase(
      answerWritingPromptRepository: injector(),
    ),
  );

  //repository
  injector.registerLazySingleton<AnswerWritingPromptRepository>(
    () => AnswerWritingPromptRepositoryImpl(
      answerWritingPromptDataSource: injector(),
    ),
  );

  //dataSource
  injector.registerLazySingleton<AnswerWritingPromptDataSource>(
    () => AnswerWritingPromptDataSourceImpl(
      webService: injector(),
    ),
  );
}
