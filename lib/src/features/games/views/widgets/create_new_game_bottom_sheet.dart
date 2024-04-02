import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/features/games/data/model/json_formater.dart';
import 'package:hareeg/src/features/games/views/blocs/games-bloc/games_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/players-bloc/players_bloc.dart';
import 'package:hareeg/src/features/games/views/widgets/create_new_player_bottom_sheet.dart';
import 'package:hareeg/src/features/games/views/widgets/player_item_widget.dart';

class CreateNewGameBottomSheet extends StatefulWidget {
  const CreateNewGameBottomSheet({super.key});

  @override
  State<CreateNewGameBottomSheet> createState() => _CreateNewGameBottomSheetState();
}

class _CreateNewGameBottomSheetState extends State<CreateNewGameBottomSheet> {
  final playersToAddList = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PlayersBloc>(context).add(GetPlayers());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                  isScrollControlled: true,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: CreateNewPlayerBottomSheet(),
                    );
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
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: playersList.length,
                    itemBuilder: (context, index) {
                      return PlayerItemWidget(
                        player: playersList[index],
                      );
                    });
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<PlayersBloc, PlayersState>(
              builder: (context, playersState) {
                return Container(
                  // color: Colors.black,
                  width: mediaQuery.width,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      if (playersState.playersToAdd != null && playersState.playersToAdd!.isNotEmpty) {
                        BlocProvider.of<GamesBloc>(context).add(CreateGame(playersState.playersToAdd!));
                        BlocProvider.of<PlayersBloc>(context).add(ClearPlayerFromAddList());
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Create Game"),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
