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
