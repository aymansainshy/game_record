import 'package:hareeg/src/features/games/data/model/game_model.dart';

abstract class PlayerRepository {
  List<Player> getPlayer();

  void createPlayer(Player players);
}

class PlayerRepositoryImpl implements PlayerRepository {
  @override
  void createPlayer(Player players) {
    // TODO: implement createPlayer
  }

  @override
  List<Player> getPlayer() {
    // TODO: implement getPlayer
    throw UnimplementedError();
  }
}
