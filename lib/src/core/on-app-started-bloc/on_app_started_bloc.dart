

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/config/app_configration.dart';
import 'package:hareeg/src/config/preferences_config.dart';
import 'package:hareeg/src/utils/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AppEvent {}

abstract class OnAppStartedAppState extends Equatable {
  const OnAppStartedAppState();

  @override
  List<Object> get props => [];
}

// APPLICATION STATE
class AppInitial extends OnAppStartedAppState {}

class AppSetupInProgress extends OnAppStartedAppState {}

class AppSetupInComplete extends OnAppStartedAppState {}

class AppSetupInFailure extends OnAppStartedAppState {
  final String error;

  const AppSetupInFailure(this.error);
}

class OnAppStartedAppBloc extends Bloc<AppEvent, OnAppStartedAppState> {
  OnAppStartedAppBloc() : super(AppInitial()) {
    on<AppStarted>((event, emit) async {
      emit(AppSetupInProgress());

      try {
        AppConfig.preferences = await SharedPreferences.getInstance();
        // PreferencesHelper.clear();

        // Setup user if Exist ......
        if (PreferencesHelper.containsKey(Preferences.user)) {
          String? userData = PreferencesHelper.getString(Preferences.user);

          if (userData != null) {
            // AppModel.user = User.fromJson(json.decode(userData));
          }
        }

        await Future.delayed(const Duration(milliseconds: 1000));

        emit(AppSetupInComplete());
      } catch (e) {
        emit(AppSetupInFailure(e.toString()));
      }
    });
  }
}
