import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/views/blocs/players-bloc/players_bloc.dart';

class PlayerItemWidget extends StatefulWidget {
  const PlayerItemWidget({
    super.key,
    required this.player,
  });

  final Player? player;

  @override
  State<PlayerItemWidget> createState() => _PlayerItemWidgetState();
}

class _PlayerItemWidgetState extends State<PlayerItemWidget> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 40,
        width: mediaQuery.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.player?.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            BlocBuilder<PlayersBloc, PlayersState>(
              builder: (context, playerState) {
                late bool? isAdded = playerState.playersToAdd?.contains(widget.player);

                return Checkbox(
                  value: isAdded,
                  onChanged: (value) {
                    isAdded = value;

                    if (value != null && value) {
                      BlocProvider.of<PlayersBloc>(context).add(AddPlayerToAddList(player: widget.player!));
                    }
                    if (value != null && !value) {
                      BlocProvider.of<PlayersBloc>(context).add(RemovePlayerToAddList(player: widget.player!));
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
