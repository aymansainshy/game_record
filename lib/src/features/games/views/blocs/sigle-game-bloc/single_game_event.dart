part of 'single_game_bloc.dart';

abstract class SingleGameEvent extends Equatable {
  const SingleGameEvent();
}

class UpdateGameDuration extends SingleGameEvent {
  const UpdateGameDuration({
    required this.game,
    required this.duration,
  });

  final int duration;
  final Game game;

  @override
  List<Object?> get props => [game, duration];
}

class UpdateGameStatus extends SingleGameEvent {
  const UpdateGameStatus({
    required this.game,
    required this.status,
  });

  final GameStatus status;
  final Game game;

  @override
  List<Object?> get props => [game, status];
}

class AddNewPlayerToCurrentGame extends SingleGameEvent {
  const AddNewPlayerToCurrentGame({
    required this.game,
    required this.players,
  });

  final List<GamePlayer> players;
  final Game game;

  @override
  List<Object?> get props => [game, players];
}
