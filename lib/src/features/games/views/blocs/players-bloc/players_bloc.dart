import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/data/repository/players_repository.dart';

part 'players_event.dart';

part 'players_state.dart';

class PlayersBloc extends Bloc<PlayersEvent, PlayersState> {
  final PlayersRepository playersRepository;

  final List<Player> playersToAdd = [];

  PlayersBloc(this.playersRepository) : super(PlayersState(players: [], playersToAdd: [])) {
    on<GetPlayers>((event, emit) {
      final players = playersRepository.getPlayersList();
      emit(state.copyWith(players: players));
    });

    on<AddPlayerToAddList>((event, emit) {
      if (playersToAdd.length < 6) {
        playersToAdd.add(event.player);
        emit(state.copyWith(playersToAdd: playersToAdd));
      }
    });

    on<RemovePlayerToAddList>((event, emit) {
      playersToAdd.remove(event.player);
      emit(state.copyWith(playersToAdd: playersToAdd));
    });

    on<ClearPlayerFromAddList>((event, emit) {
      playersToAdd.clear();
      emit(state.copyWith(playersToAdd: playersToAdd));
    });
  }
}
