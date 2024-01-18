import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/data/repository/games_repository.dart';

part 'games_event.dart';

part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GamesRepository _gameRepository;

  GamesBloc(this._gameRepository) : super(GamesInitial(games: [])) {
    final currentState = state;

    on<GetAllGames>((event, emit) async {
      emit(GamesInProgress());
      List<Game?> games = await _gameRepository.getGames();
      emit(GamesSuccess(games: games));
    });

    on<CreateGame>((event, emit) async {
      emit(GamesInProgress());
      _gameRepository.createNewGame(event.players);
      List<Game?> games = await _gameRepository.getGames();
      emit(GamesSuccess(games: games));
    });
    //
    // on<UpdateGameDuration>((event, emit) {
    //   emit(GamesInProgress());
    //   event.game.updateGameDuration(event.duration);
    //   event.game.status = GameStatus.paused;
    //   List<Game?> games = _gameRepository.getGames();
    //   emit(GamesSuccess(games: games));
    // });
    //
    //
    // on<UpdateGameStatus>((event, emit) {
    //   emit(GamesInProgress());
    //   event.game.status = event.status;
    //   List<Game?> games = _gameRepository.getGames();
    //   emit(GamesSuccess(games: games));
    // });
  }
}
