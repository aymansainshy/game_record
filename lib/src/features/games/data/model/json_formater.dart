import 'package:hareeg/src/features/games/data/model/game_model.dart';

Game gameFromJson(Map<String, dynamic> json) {
  return Game(
    id: json['id'],
    gameNo: json['gameNo'],
    champion: json['champion'],
    duration: json['duration'],
    status: getGameStatusFromJson(json['status']) ?? GameStatus.createdNew,
    players: List<GamePlayer>.from(json["gPlayers"].map((gPlayer) => gamePlayerFromJson(gPlayer))),
    createdAt: DateTime.parse(json['createdAt'].toString()),
  );
}

Map<String, dynamic> gameToJson(Game game) {
  return {
    'id': game.id,
    'gameNo': game.gameNo,
    'champion': game.champion,
    'gPlayers':
        List<Map<String, dynamic>>.from(game.getGamePlayers().map((gPlayer) => gPlayerToJson(gPlayer)).toList()),
    'status': game.status.name,
    'duration': game.getGameDuration(),
    'createdAt': game.createdAt.toIso8601String(),
  };
}

GamePlayer gamePlayerFromJson(Map<String, dynamic> json) {
  return GamePlayer(
    player: Player(
      id: json['player']['id'],
      name: json['player']['name'],
    ),
    scores: List<int>.from(json['playerScores'].map((x) => x)),
  );
}

Map<String, dynamic> gPlayerToJson(GamePlayer gPlayer) {
  return {
    'player': {
      'id': gPlayer.player.id,
      'name': gPlayer.player.name,
    },
    'playerScores': List<int>.from(gPlayer.getPlayerScores().map((x) => x).toList()),
  };
}

GameStatus? getGameStatusFromJson(String status) {
  switch (status) {
    case 'paused':
      return GameStatus.paused;
    case 'createdNew':
      return GameStatus.createdNew;
    case 'currentPlaying':
      return GameStatus.currentPlaying;
    case 'completed':
      return GameStatus.completed;
    default:
      return null;
  }
}
