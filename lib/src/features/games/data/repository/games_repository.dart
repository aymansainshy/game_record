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
        Player(id: 1, name: 'Ayman'),
        Player(id: 2, name: 'Jehad'),
      ],
      rounds: [
        Round(
          roundNumber: 1,
          playerScore: [
            PlayerScore(playerId: 1, score: 3),
            PlayerScore(playerId: 2, score: 0),
          ],
        ),
        Round(
          roundNumber: 2,
          playerScore: [
            PlayerScore(playerId: 1, score: 0),
            PlayerScore(playerId: 2, score: 18),
          ],
        ),
      ],
    ),
    Game(
      id: 2,
      status: GameStatus.completed,
      champion: 1,
      players: [
        Player(id: 1, name: 'Misbah'),
        Player(id: 2, name: 'Assad'),
      ],
      rounds: [
        Round(
          roundNumber: 1,
          playerScore: [
            PlayerScore(playerId: 1, score: 14),
            PlayerScore(playerId: 2, score: 0),
          ],
        ),
        Round(
          roundNumber: 2,
          playerScore: [
            PlayerScore(playerId: 1, score: 31),
            PlayerScore(playerId: 2, score: -13),
          ],
        ),
      ],
    ),
  ];

  @override
  List<Game> getGames() {
    return games;
  }
}
