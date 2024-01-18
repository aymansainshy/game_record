part of 'save_game_locally_bloc.dart';

abstract class SaveGameLocallyState extends Equatable {
  const SaveGameLocallyState();
}

class SaveGameLocallyInitial extends SaveGameLocallyState {
  @override
  List<Object> get props => [];
}

class SavingGameInProgress extends SaveGameLocallyState {
  @override
  List<Object?> get props => [];
}

class SavingGameFailure extends SaveGameLocallyState {
  @override
  List<Object?> get props => [];
}

class SavingGameSuccess extends SaveGameLocallyState {
  @override
  List<Object?> get props => [];
}
