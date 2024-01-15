import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/views/blocs/players-bloc/players_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/sigle-game-bloc/single_game_bloc.dart';
import 'package:hareeg/src/features/games/views/widgets/create_new_player_bottom_sheet.dart';
import 'package:hareeg/src/features/games/views/widgets/player_item_widget.dart';

class AddNewPlayerToCurrentGameSheet extends StatefulWidget {
  const AddNewPlayerToCurrentGameSheet({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  State<AddNewPlayerToCurrentGameSheet> createState() => _AddNewPlayerToCurrentGameSheetState();
}

class _AddNewPlayerToCurrentGameSheetState extends State<AddNewPlayerToCurrentGameSheet> {
  // final playersToAddList = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PlayersBloc>(context).add(GetPlayers());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return SizedBox(
      height: mediaQuery.height,
      width: mediaQuery.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add players to game',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return CreateNewPlayerBottomSheet();
                },
              );
            },
            child: Container(
              height: 40,
              width: mediaQuery.width,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.green),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.green,
                    size: 25,
                  ),
                  Text(
                    "Create a new player",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.green,
                        ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<PlayersBloc, PlayersState>(
            builder: (context, playersState) {
              if (playersState.players!.isEmpty) {
                return Center(
                  child: Text(
                    "No Players, Add them.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black45,
                        ),
                  ),
                );
              }

              final playersList = playersState.players!.reversed.toList();
              final gamePlayer = widget.game.getGamePlayers().map((gPlayer) => gPlayer.player).toList();
              final List<Player> filteredPlayers = playersList.where((player) => !gamePlayer.contains(player)).toList();

              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredPlayers.length,
                    itemBuilder: (context, index) {
                      return PlayerItemWidget(
                        player: filteredPlayers[index],
                      );
                    }),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<PlayersBloc, PlayersState>(
            builder: (context, playersState) {
              return Container(
                color: Colors.black,
                width: mediaQuery.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (playersState.playersToAdd != null && playersState.playersToAdd!.isNotEmpty) {

                      if ((widget.game.getGamePlayers().length + playersState.playersToAdd!.length) > 6) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("You can't add new Players, Max is 6 Players")),
                        );
                        return;
                      }

                      final maxScore = widget.game.maxScore();
                      final maxRound = widget.game.maxRound();

                      final gamePlayers = playersState.playersToAdd
                          ?.map(
                            (player) => GamePlayer(
                              player: player,
                              scores: maxScore > 0 ? [...List.generate(maxRound - 1, (index) => 0), maxScore] : null,
                            ),
                          )
                          .toList();

                      context.read<SingleGameBloc>().add(
                            AddNewPlayerToCurrentGame(
                              game: widget.game,
                              players: gamePlayers!,
                            ),
                          );
                      BlocProvider.of<PlayersBloc>(context).add(ClearPlayerFromAddList());
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add Player To Game"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
