import 'dart:convert';

import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/data/model/json_formater.dart';
import 'package:hive/hive.dart';

abstract class LocalDataSource {
  Future<void> saveGame(Game game);

  Future<List<Game?>?> getGames();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> saveGame(Game game) async {
    var games = await Hive.openBox('games');
    // games.clear();
    games.put(game.id, jsonEncode(gameToJson(game)));
  }

  @override
  Future<List<Game?>?> getGames() async {
    var games = await Hive.openBox('games');
    // games.clear();
    final savedGames = games.values.toList();
    // print("New Game Created From Json ....  $savedGames");
    final loadedGames = savedGames.map((game) => gameFromJson(jsonDecode(game))).toList();
    return loadedGames;
  }
}
