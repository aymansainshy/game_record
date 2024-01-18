import 'package:equatable/equatable.dart';

enum GameStatus { createdNew, currentPlaying, paused, completed }

class Game {
  final String id;
  final String gameNo;
  final List<GamePlayer> _gPlayers;
  late String? champion;
  late GameStatus status;
  late int _duration;
  final DateTime createdAt;

  Game({
    required this.id,
    required this.gameNo,
    required List<GamePlayer> players,
    required this.createdAt,
    this.champion,
    this.status = GameStatus.createdNew,
    int duration = 0,
  })  : _gPlayers = players,
        _duration = duration;

  int maxScore() {
    final soresList = this._gPlayers.map((gPlayer) => gPlayer.totalPlayerScore()).toList();
    // final filteredScores = soresList.where((score) => score <= 30).toList();
    int maxNumber = soresList.reduce((value, element) => value > element ? value : element);
    return maxNumber;
  }

  bool isContainFiredPerson() {
    final List<GamePlayer> firedPlayer = this._gPlayers.where((gPlayer) => gPlayer.totalPlayerScore() >= 31).toList();

    if (firedPlayer.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  int maxRound() {
    int maxR = 0;
    final maxScore = this.maxScore();
    final gPlayer = this._gPlayers.firstWhere((gPlayer) => gPlayer.totalPlayerScore() == maxScore);
    maxR = gPlayer.getPlayerScores().length;
    return maxR;
  }

  int getGameDuration() {
    return this._duration;
  }

  void updateGameDuration(int newDuration) {
    this._duration = newDuration;
  }

  List<GamePlayer> getGamePlayers() {
    return _gPlayers;
  }

  List<GamePlayer> getCurrentPlayers() {
    final currentPlayers = this._gPlayers.where((player) => !player.isFire()).toList();
    return currentPlayers;
  }

  void addGamePlayer(List<GamePlayer> gamePlayers) {
    this._gPlayers.addAll(gamePlayers);
  }

  void changeGameStatus(GameStatus gameStatus) {
    this.status = gameStatus;
  }

  void addChampion(String playerId) {
    this.champion = id;
  }

  GamePlayer? getGameChampion(String? id) {
    return this._gPlayers.firstWhere((gPlayer) => gPlayer.player.id == id);
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

  bool addScore(int? newScore) {
    this._playerScores.add(newScore);

    if (isFire()) {
      print("WWWWWiiiiiiii ${this.player.name} iiiiiiiiiiiiiii");
    }

    return isFire();
  }

  int totalPlayerScore() {
    late int totalScore = 0;

    this._playerScores.forEach((int? score) {
      if (score == null) {
        return;
      }
      totalScore = totalScore + score;
    });
    return totalScore;
  }
}

class Player extends Equatable {
  final String id;
  final String name;

  Player({
    required this.id,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
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
