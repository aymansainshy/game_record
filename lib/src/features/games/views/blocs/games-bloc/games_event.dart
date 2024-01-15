part of 'games_bloc.dart';

abstract class GamesEvent extends Equatable {
  const GamesEvent();
}

class GetAllGames extends GamesEvent {
  const GetAllGames();

  @override
  List<Object?> get props => [];
}

class CreateGame extends GamesEvent {
  const CreateGame(this.players);

  final List<Player> players;

  @override
  List<Object?> get props => [players];
}

// class UpdateGameDuration extends GamesEvent {
//   const UpdateGameDuration({
//     required this.game,
//     required this.duration,
//   });
//
//   final int duration;
//   final Game game;
//
//   @override
//   List<Object?> get props => [game, duration];
// }
//
// class UpdateGameStatus extends GamesEvent {
//   const UpdateGameStatus({
//     required this.game,
//     required this.status,
//   });
//
//   final GameStatus status;
//   final Game game;
//
//   @override
//   List<Object?> get props => [game, status];
// }
