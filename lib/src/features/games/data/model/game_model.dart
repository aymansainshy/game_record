enum GameStatus { createdNew, currentPlaying, paused, completed }

class Game {
  final String id;
  final String gameNo;
  late GameStatus status;
  late List<GamePlayer> players;
  late String? champion;

  Game({
    required this.id,
    required this.gameNo,
    required this.players,
    this.champion,
    this.status = GameStatus.createdNew,
  });

  List<GamePlayer>? getCurrentPlayers() {
    final currentPlayers = players.where((player) => !player.isFire()).toList();
    return currentPlayers;
  }

  void addGamePlayer(GamePlayer gamePlayer) {
    this.players.add(gamePlayer);
  }

  void changeGameStatus(GameStatus gameStatus) {
    this.status = gameStatus;
  }

  void addChampion(String playerId) {
    this.champion = id;
  }

  GamePlayer? getGameChampion(String? id) {
    return players.firstWhere((player) => player.player.id == id);
  }
}

class GamePlayer {
  final Player player;
  late List<int?>? playerScores;

  GamePlayer({
    required this.player,
    this.playerScores = const [],
  });

  bool isFire() {
    return totalPlayerScore() >= 31;
  }

  bool? isChampion(Game game) {
    return game.champion == this.player.id;
  }

  void addScore(int? newScore) {
    this.playerScores?.add(newScore);
  }

  int totalPlayerScore() {
    late int totalScore = 0;

    playerScores?.forEach((score) {
      totalScore = totalScore + score!;
    });
    return totalScore;
  }
}

class Player {
  final String id;
  final String name;

  Player({
    required this.id,
    required this.name,
  });
}

// class PlayerScore {
//   final List<int?>? scores;
//
//   PlayerScore({
//     this.scores,
//   });
//
//   int totalPlayerScore() {
//     late int totalScore = 0;
//
//     scores?.forEach((score) {
//       totalScore = totalScore + score!;
//     });
//
//     return totalScore;
//   }
//
//   void addScore(int? score) {
//     this.scores?.add(score);
//   }
// }

// class Round {
//   final int roundNumber;
//   final int? score;
//
//   Round({
//     required this.roundNumber,
//     this.score = 0,
//   });
// }
