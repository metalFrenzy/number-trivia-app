import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/number_trivia/data/repository/number_trivia_repo_impl.dart';
import 'features/number_trivia/data/sources/number_trivia_local_source.dart';
import 'features/number_trivia/data/sources/number_trivia_remote_source.dart';
import 'features/number_trivia/domain/repo/number_trivia_repo.dart';
import 'features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //! features
  //bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      getNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl(),
    ),
  );
  //usescase
  sl.registerLazySingleton(() => GetNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTriva(sl()));

  //repo
  sl.registerLazySingleton<NumberTriviaRepo>(
    () => NumberTriviaRepoImpl(
      remote: sl(),
      local: sl(),
      networkInfo: sl(),
    ),
  );

  //data source
  sl.registerLazySingleton<NumberTriviaRemoteSource>(
      () => NumberTriviaRemoteSourceImpl(sl()));
  sl.registerLazySingleton<NumberTriviaLocalSource>(
      () => NumberTriviaLocalSourceImp(sl()));

  //core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //external
  final sharedPrerences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrerences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerSingleton<InternetConnectionChecker>(InternetConnectionChecker());
}
