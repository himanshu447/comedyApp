import 'package:comedy/feacture/write_whthout_prompt/data/datasource/write_without_prompt_data_source.dart';
import 'package:comedy/feacture/write_whthout_prompt/data/repository/write_without_prompt_repository_impl.dart';
import 'package:comedy/feacture/write_whthout_prompt/presentation/bloc/write_without_prompt_bloc.dart';
import 'package:comedy/share/prompt/data/datasource/prompt_datasource.dart';
import 'package:comedy/share/prompt/data/repository/prompt_repository_impl.dart';
import 'package:comedy/share/prompt/domain/repository/prompt_repository.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'feacture/landing/presentation/bloc/landing_bloc.dart';
import 'feacture/submit_prompt/domain/usecase/submit_prompt_usecase.dart';
import 'feacture/submit_prompt/presentation/bloc/submit_prompt_bloc.dart';
import 'feacture/write_whthout_prompt/domain/repository/write_without_prompt_repository.dart';
import 'feacture/write_whthout_prompt/domain/usecase/submit_write_without_prompt_usecase.dart';

final injector = GetIt.instance;

Future init() async {
  ///External
  injector.registerLazySingleton(() => http.Client());
  injector.registerLazySingleton(() => WebService());

  ///Landing Bloc
  injector.registerFactory(() => LandingBloc());

  ///Write without prompt
  _writeWithoutPrompt();

  ///Write without prompt
  _submitPrompt();
}

void _writeWithoutPrompt() {
  //bloc
  injector.registerFactory(() =>
      WriteWithoutPromptBloc(submitWriteWithoutPromptUseCase: injector()));

  //useCase
  injector.registerLazySingleton(
    () => SubmitWriteWithoutPromptUseCase(
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
    ),
  );
}

void _submitPrompt() {
  //bloc
  injector
      .registerFactory(() => SubmitPromptBloc(submitPromptUseCase: injector()));

  //useCase
  injector.registerLazySingleton(
    () => SubmitPromptUseCase(
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
