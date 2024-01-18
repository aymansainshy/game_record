import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';

part 'save_game_locally_event.dart';

part 'save_game_locally_state.dart';

class SaveGameLocallyBloc extends Bloc<SaveGameLocallyEvent, SaveGameLocallyState> {
  SaveGameLocallyBloc() : super(SaveGameLocallyInitial()) {
    on<SaveGameStatus>((event, emit) async {
      emit(SavingGameInProgress());
      await Future.delayed(Duration(milliseconds: 3000));
      emit(SavingGameSuccess());
    });
  }
}
