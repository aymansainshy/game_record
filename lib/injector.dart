import 'package:get_it/get_it.dart';
import 'package:hareeg/src/core/on-app-started-bloc/on_app_started_bloc.dart';
import 'package:hareeg/src/features/games/data/repository/games_repository.dart';
import 'package:hareeg/src/features/games/data/repository/timer.dart';
import 'package:hareeg/src/features/games/views/blocs/game-timer-bloc/game_timer_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/games-bloc/games_bloc.dart';

import 'src/router/app_router.dart';

final inject = GetIt.instance;

void setup() {
  // HttpClient
  // inject.registerLazySingleton<NetworkServices>(() => DioClient());

  // Timer
  inject.registerLazySingleton<Ticker>(() => Ticker());

  // Repositories
  inject.registerLazySingleton<GamesRepository>(() => GamesRepositoryImpl());

  inject.registerLazySingleton<OnAppStartedAppBloc>(() => OnAppStartedAppBloc());
  inject.registerLazySingleton<GamesBloc>(() => GamesBloc(inject()));
  inject.registerLazySingleton<GameTimerBloc>(() => GameTimerBloc(inject()));

  // AppRouter
  inject.registerSingleton<AppRouter>(AppRouter());
}
