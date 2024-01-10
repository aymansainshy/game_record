enum GameStatus { currentPlaying, paused, completed }

class Game {
  final int id;
  late List<Player> players;
  late int? champion;
  late List<Round>? rounds;
  late GameStatus status;

  Game({
    required this.id,
    required this.players,
    this.champion,
    this.rounds,
    this.status = GameStatus.currentPlaying,
  });

  double? totalPlayerScore(int? playerId) {
    late double? totalScore = 0.0;

    late List<PlayerScore?>? playerScores = [];

    rounds?.forEach((round) {
      final loadedScores = round.playerScore?.where((pScore) => pScore?.playerId == playerId).toList();
      playerScores = loadedScores;
    });

    final scores = playerScores?.map((playerScore) => playerScore?.score).toList();

    totalScore = scores?.fold(0.0, (previousValue, score) => previousValue + score!);
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
  final List<PlayerScore?>? playerScore;
  late double? totalScore;

  Round({
    required this.roundNumber,
    required this.playerScore,
  });

// double? totalPlayerScore(int playerId) {
//   late double? totalScore = 0.0;
//   final playerScores = playerScore?.where((playerScore) => playerScore?.playerId.toString() == playerId.toString()).toList();
//   totalScore = playerScores?.fold(0.0, (previousValue, playerScores) => previousValue + playerScores!.score);
//   return totalScore;
// }
}

class PlayerScore {
  final int playerId;
  final double score;

  PlayerScore({
    required this.playerId,
    this.score = 0.0,
  });
}
