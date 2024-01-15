import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';

part 'single_game_event.dart';

part 'single_game_state.dart';

class SingleGameBloc extends Bloc<SingleGameEvent, SingleGameState> {
  SingleGameBloc() : super(SingleGameState()) {
    on<UpdateGameDuration>((event, emit) {
      event.game.updateGameDuration(event.duration);
      event.game.status = GameStatus.paused;
      emit(SingleGameState());
    });

    on<UpdateGameStatus>((event, emit) {
      event.game.status = event.status;
      emit(SingleGameState());
    });
  }
}
