part of 'games_bloc.dart';

abstract class GamesEvent extends Equatable {
  const GamesEvent();
}

class GetAllGames extends GamesEvent {
  const GetAllGames();

  @override
  List<Object?> get props => [];
}
