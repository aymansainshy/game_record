import 'package:get_it/get_it.dart';
import 'package:hareeg/src/core/on-app-started-bloc/on_app_started_bloc.dart';
import 'package:hareeg/src/features/games/data/repository/games_repository.dart';
import 'package:hareeg/src/features/games/data/repository/players_repository.dart';
import 'package:hareeg/src/features/games/data/repository/timer.dart';
import 'package:hareeg/src/features/games/data/storage/local_date_source.dart';
import 'package:hareeg/src/features/games/views/blocs/game-timer-bloc/game_timer_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/games-bloc/games_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/players-bloc/players_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/save-game-locally-bloc/save_game_locally_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/sigle-game-bloc/single_game_bloc.dart';

import 'src/router/app_router.dart';

final inject = GetIt.instance;

void setup() {
  // HttpClient
  // inject.registerLazySingleton<NetworkServices>(() => DioClient());

  // Timer
  inject.registerLazySingleton<Ticker>(() => Ticker());
  inject.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // Repositories
  inject.registerLazySingleton<GamesRepository>(() => GamesRepositoryImpl(inject()));
  inject.registerLazySingleton<PlayersRepository>(() => PlayersRepositoryImpl());

  inject.registerLazySingleton<OnAppStartedAppBloc>(() => OnAppStartedAppBloc());
  inject.registerLazySingleton<SingleGameBloc>(() => SingleGameBloc());
  inject.registerLazySingleton<SaveGameLocallyBloc>(() => SaveGameLocallyBloc(inject()));
  inject.registerLazySingleton<GamesBloc>(() => GamesBloc(inject()));
  inject.registerLazySingleton<GameTimerBloc>(() => GameTimerBloc(inject()));
  inject.registerLazySingleton<PlayersBloc>(() => PlayersBloc(inject()));

  // AppRouter
  inject.registerSingleton<AppRouter>(AppRouter());
}
