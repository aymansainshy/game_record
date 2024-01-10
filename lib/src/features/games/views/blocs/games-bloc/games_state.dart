part of 'games_bloc.dart';

abstract class GamesState extends Equatable {
  const GamesState();
}

class GamesInitial extends GamesState {
  @override
  List<Object> get props => [];
}

class GamesInProgress extends GamesState {
  @override
  List<Object?> get props => [];
}

class GamesSuccess extends GamesState {
  final List<Game?> games;

  GamesSuccess(this.games);

  @override
  List<Object?> get props => [];
}

class GamesFailure extends GamesState {
  @override
  List<Object?> get props => [];
}
