import 'package:comedy/feacture/landing/presentation/bloc/landing_bloc.dart';
import 'package:comedy/share/service/web_service.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future init() async {
  ///External
  injector.registerLazySingleton(() => http.Client());
  injector.registerLazySingleton(() => WebService());

  ///Landing Bloc
  injector.registerFactory(() => LandingBloc());
}
