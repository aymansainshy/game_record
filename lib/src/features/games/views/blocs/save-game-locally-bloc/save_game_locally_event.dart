part of 'save_game_locally_bloc.dart';

abstract class SaveGameLocallyEvent extends Equatable {
  const SaveGameLocallyEvent();
}

class SaveGameStatus extends SaveGameLocallyEvent {
  final Game game;

  SaveGameStatus({required this.game});

  @override
  List<Object?> get props => [];
}
