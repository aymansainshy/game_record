part of 'games_bloc.dart';

abstract class GamesState extends Equatable {
  final List<Game?>? games;

  const GamesState({this.games});

  @override
  List<Object?> get props => [games];
}

class GamesInitial extends GamesState {
  GamesInitial({super.games});
}

class GamesInProgress extends GamesState {
  GamesInProgress();
}

class GamesSuccess extends GamesState {
  GamesSuccess({super.games});

// GamesSuccess copyWith({List<Game?>? games}) {
//   return GamesSuccess(games: games ?? this.games);
// }
}

class GamesFailure extends GamesState {
  GamesFailure();
}
