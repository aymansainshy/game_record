import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/views/blocs/game-timer-bloc/game_timer_bloc.dart';
import 'package:hareeg/src/router/app_router.dart';
import 'package:hareeg/src/theme/app_theme.dart';
import 'package:intl/intl.dart';

class GameItemWidget extends StatelessWidget {
  const GameItemWidget({
    Key? key,
    required this.game,
    this.minutes,
    this.seconds,
  }) : super(key: key);

  final Game? game;

  final String? minutes;
  final String? seconds;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (game?.status == GameStatus.currentPlaying) {
          context.read<GameTimerBloc>().add(TimerStarted(duration: 799));
        }

        context.push(RouteName.gameBoard);
      },
      child: Container(
        height: 150,
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      color: AppColors.primaryColorHex,
                    ),
                    const SizedBox(width: 10),
                    Transform.translate(
                      offset: const Offset(0, 2),
                      child: Text(
                        "Game #${game?.id}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 2),
                        child: Text(
                          "00 : 00 : 00",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.black45,
                              ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      if (game?.status == GameStatus.currentPlaying)
                        Icon(
                          CupertinoIcons.play_arrow_solid,
                          color: AppColors.primaryColorHex,
                        ),
                      if (game?.status == GameStatus.completed)
                        Icon(
                          CupertinoIcons.timer_fill,
                          color: AppColors.primaryColorHex,
                        ),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              DateFormat.yMMMMEEEEd().format(DateTime.now()),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Champion",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                  ),
                  TextSpan(
                    text: game?.champion != null
                        ? "   👑  ${game?.players[game!.champion!].name}  👑"
                        : "  No Champion Yet",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primaryColorHex,
                          fontSize: 20,
                        ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Score    ",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                      ),
                      TextSpan(
                        text: game?.champion != null
                            ? "${game?.totalPlayerScore(game?.players[game!.champion!].id)}"
                            : "--",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.redAccent,
                            ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 25,
                  child: Row(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 3),
                        child: SizedBox(
                          height: 21,
                          child: Text(
                            game?.status == GameStatus.currentPlaying ? "Continue" : "Details",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                  // fontSize: 14,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const RotatedBox(
                        quarterTurns: 0,
                        child: Icon(
                          CupertinoIcons.forward,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
