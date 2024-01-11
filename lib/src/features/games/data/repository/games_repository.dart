import 'package:hareeg/src/features/games/data/model/game_model.dart';

abstract class GamesRepository {
  List<Game> getGames();
}

class GamesRepositoryImpl implements GamesRepository {
  final List<Game> games = [
    Game(
      id: 1,
      status: GameStatus.currentPlaying,
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
            ],
          ),
        ),
        GamePlayer(
          player: Player(id: 2, name: 'Jehad'),
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
  ];

  @override
  List<Game> getGames() {
    return games;
  }
}
