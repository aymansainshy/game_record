enum GameStatus { createdNew, currentPlaying, paused, completed }

class Game {
  final String id;
  final String gameNo;
  final List<GamePlayer> _players;
  late String? champion;
  late GameStatus status;
  late int _duration;

  Game({
    required this.id,
    required this.gameNo,
    required List<GamePlayer> players,
    this.champion,
    this.status = GameStatus.createdNew,
    int duration = 0,
  })  : _players = players,
        _duration = duration;

  int getGameDuration() {
    return this._duration;
  }

  void updateGameDuration(int newDuration) {
    this._duration = newDuration;
  }

  List<GamePlayer> getGamePlayers() {
    return _players;
  }

  List<GamePlayer>? getCurrentPlayers() {
    final currentPlayers = this._players.where((player) => !player.isFire()).toList();
    return currentPlayers;
  }

  void addGamePlayer(GamePlayer gamePlayer) {
    this._players.add(gamePlayer);
  }

  void changeGameStatus(GameStatus gameStatus) {
    this.status = gameStatus;
  }

  void addChampion(String playerId) {
    this.champion = id;
  }

  GamePlayer? getGameChampion(String? id) {
    return this._players.firstWhere((gPlayer) => gPlayer.player.id == id);
  }
}

class GamePlayer {
  final Player player;
  final List<int?> _playerScores;

  GamePlayer({
    required this.player,
    List<int?>? scores,
  }) : _playerScores = scores ?? [];

  List<int?> getPlayerScores() {
    return _playerScores;
  }

  bool isFire() {
    return totalPlayerScore() >= 31;
  }

  bool? isChampion(Game game) {
    return game.champion == this.player.id;
  }

  void addScore(int? newScore) {
    this._playerScores.add(newScore);
  }

  int totalPlayerScore() {
    late int totalScore = 0;

    this._playerScores.forEach((score) {
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
