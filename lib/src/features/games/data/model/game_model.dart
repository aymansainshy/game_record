enum GameStatus { currentPlaying, paused, completed }

class Game {
  final int id;
  late GameStatus status;
  late List<GamePlayer> players;
  late int? champion;

  Game({
    required this.id,
    required this.players,
    this.champion,
    this.status = GameStatus.currentPlaying,
  });

  void addGamePlayer(GamePlayer gamePlayer) {
    this.players.add(gamePlayer);
  }

  void changeGameStatus(GameStatus gameStatus) {
    this.status = gameStatus;
  }

  GamePlayer? getGameChampion(int? id) {
    return players.firstWhere((player) => player.player.id.toString() == id.toString());
  }

// int totalPlayerScore(int? id) {
//   late int totalScore = 0;
//
//   final GamePlayer gamePlayer = players.firstWhere((player) => player.player.id.toString() == id.toString());
//   gamePlayer.playerScore?.rounds?.forEach((round) {
//     totalScore = totalScore + round.score!;
//   });
//
//   return totalScore;
// }
}

class GamePlayer {
  final Player player;
  final PlayerScore? playerScore;

  GamePlayer({
    required this.player,
    this.playerScore,
  });

  void addScore(int? score, int roundNumber) {
    this.playerScore?.rounds?.add(Round(
          roundNumber: roundNumber,
          score: score,
        ));
  }

  int totalPlayerScore() {
    late int totalScore = 0;

    playerScore?.rounds?.forEach((round) {
      totalScore = totalScore + round.score!;
    });

    return totalScore;
  }
}

class Player {
  final int id;
  final String name;

  Player({
    required this.id,
    required this.name,
  });
}

class Round {
  final int roundNumber;
  final int? score;

  Round({
    required this.roundNumber,
    this.score = 0,
  });
}

class PlayerScore {
  final List<Round>? rounds;
  late int? totalScore;

  PlayerScore({
    this.rounds,
  });
}
