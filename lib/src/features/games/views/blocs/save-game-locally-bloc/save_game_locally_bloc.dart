import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/data/repository/games_repository.dart';

part 'save_game_locally_event.dart';

part 'save_game_locally_state.dart';

class SaveGameLocallyBloc extends Bloc<SaveGameLocallyEvent, SaveGameLocallyState> {
  final GamesRepository gamesRepository;

  SaveGameLocallyBloc(this.gamesRepository) : super(SaveGameLocallyInitial()) {
    on<SaveGameStatus>((event, emit) async {
      emit(SavingGameInProgress());
      await Future.delayed(Duration(milliseconds: 500));
      await gamesRepository.updateAndSaveGame(event.game);
      emit(SavingGameSuccess());
    });
  }
}
