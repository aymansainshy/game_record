import 'dart:math';

import 'package:hareeg/src/features/games/data/model/game_model.dart';

abstract class GamesRepository {
  List<Game> getGames();

  void createNewGame(List<Player> players);
}

class GamesRepositoryImpl implements GamesRepository {
  final List<Game> games = [
    Game(
      id: 1,
      status: GameStatus.paused,
      champion: null,
      players: [
        GamePlayer(
          player: Player(id: 1, name: 'Ayman'),
          playerScore: PlayerScore(
            rounds: [
              Round(
                roundNumber: 1,
                score: 4,
              ),
              Round(
                roundNumber: 2,
                score: 3,
              ),
              Round(
                roundNumber: 3,
                score: 3,
              ),
              Round(
                roundNumber: 4,
                score: -1,
              ),
              Round(
                roundNumber: 5,
                score: 3,
              ),
              Round(
                roundNumber: 6,
                score: 6,
              ),
            ],
          ),
        ),
        GamePlayer(
          player: Player(id: 2, name: 'Jihad'),
          playerScore: PlayerScore(
            rounds: [
              Round(
                roundNumber: 1,
                score: 0,
              ),
              Round(
                roundNumber: 2,
                score: 8,
              ),
              Round(
                roundNumber: 3,
                score: 4,
              ),
              Round(
                roundNumber: 4,
                score: 5,
              ),
              Round(
                roundNumber: 5,
                score: -1,
              ),
              Round(
                roundNumber: 6,
                score: -1,
              ),
            ],
          ),
        ),
        GamePlayer(
          player: Player(id: 3, name: 'Asaad'),
          playerScore: PlayerScore(
            rounds: [
              Round(
                roundNumber: 1,
                score: 14,
              ),
              Round(
                roundNumber: 2,
                score: 3,
              ),
              Round(
                roundNumber: 3,
                score: 14,
              ),
            ],
          ),
        ),
        GamePlayer(
          player: Player(id: 4, name: 'Misbah'),
          playerScore: PlayerScore(
            rounds: [
              Round(
                roundNumber: 1,
                score: 8,
              ),
              Round(
                roundNumber: 2,
                score: 2,
              ),
              Round(
                roundNumber: 3,
                score: -1,
              ),
              Round(
                roundNumber: 4,
                score: 14,
              ),
              Round(
                roundNumber: 5,
                score: 14,
              ),
            ],
          ),
        ),
      ],
    ),
    Game(
      id: 2,
      status: GameStatus.completed,
      champion: 3,
      players: [
        GamePlayer(
          player: Player(id: 3, name: 'Asaad'),
          playerScore: PlayerScore(
            rounds: [
              Round(
                roundNumber: 1,
                score: 0,
              ),
              Round(
                roundNumber: 2,
                score: -3,
              ),
            ],
          ),
        ),
        GamePlayer(
          player: Player(id: 4, name: 'Misbah'),
          playerScore: PlayerScore(
            rounds: [
              Round(
                roundNumber: 1,
                score: 14,
              ),
              Round(
                roundNumber: 2,
                score: 17,
              ),
            ],
          ),
        ),
      ],
    ),
    Game(
      id: 3,
      status: GameStatus.paused,
      champion: null,
      players: [
        GamePlayer(
          player: Player(id: 3, name: 'Asaad'),
        ),
        GamePlayer(
          player: Player(id: 4, name: 'Misbah'),
        ),
      ],
    ),
  ];

  @override
  List<Game> getGames() {
    return games;
  }

  @override
  void createNewGame(List<Player> players) {
    final id = Random().nextInt(1000);
    final gamePlayer = players.map((player) => GamePlayer(player: player)).toList();
    final newGame = Game(id: id, players: gamePlayer);
    games.add(newGame);
  }
}
