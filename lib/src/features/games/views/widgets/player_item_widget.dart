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
  late bool? isAdded = false;

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
            Checkbox(
              value: isAdded,
              onChanged: (value) {
                setState(() {
                  isAdded = value;
                });
                if (value != null && value) {
                  BlocProvider.of<PlayersBloc>(context).add(AddPlayerToAddList(player: widget.player!));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
