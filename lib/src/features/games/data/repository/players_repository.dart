import 'package:hareeg/src/features/games/data/model/game_model.dart';

abstract class PlayersRepository {
  List<Player> getPlayersList();

  void createPlayer(Player players);
}

class PlayersRepositoryImpl implements PlayersRepository {
  final List<Player> _players = [
    Player(id: 1, name: 'Ayman'),
    Player(id: 2, name: 'Jihad'),
    Player(id: 3, name: 'Assad'),
    Player(id: 4, name: 'Misbah'),
  ];

  @override
  void createPlayer(Player players) {
    // TODO: implement createPlayer
  }

  @override
  List<Player> getPlayersList() {
    return _players;
  }
}
