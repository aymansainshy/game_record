part of 'players_bloc.dart';

// abstract class PlayersState extends Equatable {
//   final List<Player>? players;
//   final List<Player>? playersToAdd;
//
//   const PlayersState(this.players, this.playersToAdd);
//
//   @override
//   List<Object?> get props => [players, playersToAdd];
// }

class PlayersState {
  final List<Player>? players;
  final List<Player>? playersToAdd;

  PlayersState({
    this.players,
    this.playersToAdd,
  });

  PlayersState copyWith({List<Player>? players, List<Player>? playersToAdd}) {
    return PlayersState(
      players: players ?? this.players,
      playersToAdd: playersToAdd ?? this.playersToAdd,
    );
  }
}
