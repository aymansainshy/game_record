import 'dart:convert';
import 'dart:math';

import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/data/model/json_formater.dart';
import 'package:hareeg/src/features/games/data/storage/local_date_source.dart';

abstract class GamesRepository {
  Future<List<Game?>> getGames();

  Future<void> createNewGame(List<Player> players);

  Future<void> updateAndSaveGame(Game game);
}

class GamesRepositoryImpl implements GamesRepository {
  GamesRepositoryImpl(this.localDataSource);

  final LocalDataSource localDataSource;

  late List<Game?> _games = [];
  final List<Game> games = [
    Game(
      gameNo: "7841",
      id: DateTime.now().toIso8601String(),
      createdAt: DateTime.now(),
      status: GameStatus.paused,
      champion: null,
      players: [
        GamePlayer(
          player: Player(id: "1", name: 'Ayman'),
          scores: [4, 3, 3, -1, 3, 6],
        ),
        GamePlayer(
          player: Player(id: "2", name: 'Jihad'),
          scores: [0, 8, 4, 5, -1, -1],
        ),
        GamePlayer(
          player: Player(id: "3", name: 'Asaad'),
          scores: [14, 3, 14],
        ),
        GamePlayer(
          player: Player(id: "4", name: 'Misbah'),
          scores: [8, 2, -1, 14, 14],
        ),
      ],
    ),
    Game(
      gameNo: "1211",
      duration: 234567,
      id: DateTime.now().toIso8601String(),
      createdAt: DateTime.now(),
      status: GameStatus.completed,
      champion: "3",
      players: [
        GamePlayer(
          player: Player(id: "3", name: 'Asaad'),
          scores: [0, -3],
        ),
        GamePlayer(
          player: Player(id: "4", name: 'Misbah'),
          scores: [14, 17],
        ),
      ],
    ),
    Game(
      gameNo: "2411",
      id: DateTime.now().toIso8601String(),
      createdAt: DateTime.now(),
      status: GameStatus.paused,
      champion: null,
      players: [
        GamePlayer(
          player: Player(id: "3", name: 'Asaad'),
        ),
        GamePlayer(
          player: Player(id: "4", name: 'Misbah'),
        ),
      ],
    ),
  ];

  @override
  Future<List<Game?>> getGames() async {
    final loadedGames = await localDataSource.getGames();

    if (loadedGames != null) {
      _games = loadedGames;
    }
    return _games;
  }

  @override
  Future<void> createNewGame(List<Player> players) async {
    final String gameNo = Random().nextInt(9999).toString();
    final String id = DateTime.now().toIso8601String();
    final gamePlayers = players.map((player) => GamePlayer(player: player)).toList();
    final newGame = Game(id: id, gameNo: gameNo, players: gamePlayers, createdAt: DateTime.now());

    await localDataSource.saveGame(newGame);

    _games.add(newGame);
  }

  @override
  Future<void> updateAndSaveGame(Game game) async {
    await localDataSource.saveGame(game);
  }
}
