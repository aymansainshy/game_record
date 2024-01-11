import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/config/app_model.dart';
import 'package:hareeg/src/core/on-app-started-bloc/on_app_started_bloc.dart';
import 'package:hareeg/src/core/widgets/splash_view.dart';
import 'package:hareeg/src/features/games/views/blocs/game-timer-bloc/game_timer_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/games-bloc/games_bloc.dart';
import 'package:hareeg/src/router/app_router.dart';
import 'package:hareeg/src/theme/app_theme.dart';
import 'package:hareeg/src/utils/assets_helper.dart';

import 'injector.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundColor,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<OnAppStartedAppBloc>(create: (context) => inject<OnAppStartedAppBloc>()..add(AppStarted())),
        BlocProvider<GamesBloc>(create: (context) => inject<GamesBloc>()),
        BlocProvider<GameTimerBloc>(create: (context) => inject<GameTimerBloc>()),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: AppColors.backgroundColor, // Set your desired color here
        ),
        child: BlocConsumer<OnAppStartedAppBloc, OnAppStartedAppState>(
          listener: (context, appState) {
            if (appState is AppSetupInComplete) {}
          },
          builder: (context, appState) {
            if (appState is AppSetupInComplete) {
              return MaterialApp.router(
                title: AppModel.appName,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                routerConfig: inject<AppRouter>().router,
              );
            }
            return AnimatedSplashView(
              duration: 500,
              imagePath: AssetsUtils.cardImage,
            );
          },
        ),
      ),
    );
  }
}
