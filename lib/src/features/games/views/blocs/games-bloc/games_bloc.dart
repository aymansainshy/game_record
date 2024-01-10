import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/data/repository/games_repository.dart';

part 'games_event.dart';

part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GamesRepository _gameRepository;
  late List<Game?> games = [];

  GamesBloc(this._gameRepository) : super(GamesInitial()) {
    on<GetAllGames>((event, emit) {
      emit(GamesInProgress());
      games = _gameRepository.getGames();
      emit(GamesSuccess(games));
    });
  }
}
