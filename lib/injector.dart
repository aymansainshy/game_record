import 'package:get_it/get_it.dart';
import 'package:hareeg/src/core/on-app-started-bloc/on_app_started_bloc.dart';

import 'src/router/app_router.dart';

final inject = GetIt.instance;

void setup() {
  // HttpClient
  // inject.registerLazySingleton<NetworkServices>(() => DioClient());

  // Repositories
  // inject.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(inject()));
  // inject.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(inject()));
  // inject.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(inject()));

  // Blocs
  // inject.registerLazySingleton<AuthCheckCubit>(() => AuthCheckCubit());
  // inject.registerLazySingleton<LogOutCubit>(() => LogOutCubit(inject()));

  inject.registerLazySingleton<OnAppStartedAppBloc>(() => OnAppStartedAppBloc());
  // inject.registerLazySingleton<LoginBloc>(() => LoginBloc(inject()));
  // inject.registerLazySingleton<RegisterBloc>(() => RegisterBloc(inject()));


  // AppRouter
  inject.registerSingleton<AppRouter>(AppRouter());
}
