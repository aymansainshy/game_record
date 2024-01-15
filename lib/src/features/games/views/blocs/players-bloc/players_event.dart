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

class RemovePlayerToAddList extends PlayersEvent {
  final Player player;

  RemovePlayerToAddList({required this.player});

  @override
  List<Object?> get props => [player];
}

class ClearPlayerFromAddList extends PlayersEvent {
  @override
  List<Object?> get props => [];
}

class CreateNewPlayer extends PlayersEvent {
  final String name;

  const CreateNewPlayer({required this.name});

  @override
  List<Object?> get props => [];
}
