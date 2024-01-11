part of 'players_bloc.dart';

abstract class PlayersEvent extends Equatable {
  const PlayersEvent();
}

class GetPlayers extends PlayersEvent {
  @override
  List<Object?> get props => [];
}

class AddPlayerToAddList extends PlayersEvent {
  final Player player;

  AddPlayerToAddList({required this.player});

  @override
  List<Object?> get props => [player];
}

class ClearPlayerFromAddList extends PlayersEvent {
  @override
  List<Object?> get props => [];
}
