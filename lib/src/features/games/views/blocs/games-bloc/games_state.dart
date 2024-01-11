part of 'games_bloc.dart';

// abstract class GamesState {
//   final List<Game?> games;
//
//   const GamesState(this.games);
// }
//
// class GamesInitial extends GamesState {
//   GamesInitial(super.games);
// }
//
// class GamesInProgress extends GamesState {
//   GamesInProgress(super.games);
// }

class GamesState {
  final List<Game?> games;

  GamesState({
    required this.games,
  });

  GamesState copyWith({List<Game?>? games}) {
    return GamesState(games: games ?? this.games);
  }
}

// class GamesFailure extends GamesState {
//   GamesFailure(super.games);
// }
