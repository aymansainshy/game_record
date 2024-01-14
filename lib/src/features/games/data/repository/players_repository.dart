import 'package:hareeg/src/features/games/data/model/game_model.dart';

abstract class PlayersRepository {
  List<Player> getPlayersList();

  void createPlayer(String name);
}

class PlayersRepositoryImpl implements PlayersRepository {
  final List<Player> _players = [
    Player(id: "1", name: 'Ayman'),
    Player(id: "2", name: 'Jihad'),
    Player(id: "3", name: 'Assad'),
    Player(id: "4", name: 'Misbah'),
  ];

  @override
  void createPlayer(String name) {
    final id = DateTime.now().toIso8601String();
    final player = Player(id: id, name: name);
    _players.add(player);
  }

  @override
  List<Player> getPlayersList() {
    return _players;
  }
}
