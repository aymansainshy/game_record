import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/views/blocs/game-timer-bloc/game_timer_bloc.dart';
import 'package:hareeg/src/router/app_router.dart';
import 'package:hareeg/src/theme/app_theme.dart';
import 'package:hareeg/src/utils/assets_helper.dart';
import 'package:intl/intl.dart';

class GameItemWidget extends StatelessWidget {
  const GameItemWidget({
    Key? key,
    required this.game,
    this.minutes,
    this.seconds,
  }) : super(key: key);

  final Game game;

  final String? minutes;
  final String? seconds;

  @override
  Widget build(BuildContext context) {
    final duration = game.getGameDuration();

    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    final hoursStr = (((duration / 60) / 60) % 60).floor().toString().padLeft(2, '0');
    // final mediaQuery = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        if (game.status == GameStatus.currentPlaying) {
          context.read<GameTimerBloc>().add(TimerStarted(
                duration: game.getGameDuration(),
                gameId: game.id,
              ));
        } else {
          context.read<GameTimerBloc>().add(SetTimerInitial(
                duration: game.getGameDuration(),
                gameId: game.id,
              ));
        }

        context.push(RouteName.gameBoard, extra: game);
      },
      child: Container(
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              game.status == GameStatus.completed ? Theme.of(context).colorScheme.secondary : AppColors.primaryColorHex,
          border: Border.all(
            width: 4,
            color: game.status == GameStatus.createdNew ? Color(0xFF4DE354) : AppColors.primaryColorHex,
          ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(AssetsUtils.cardImage),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(0, 2),
                        child: Text(
                          "Game# ${game.gameNo}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ],
                )),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 2),
                        child: Text(
                          "${hoursStr} : ${minutesStr} : ${secondsStr}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: game.status == GameStatus.createdNew ? Color(0xFF4DE354) : Colors.white,
                              ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      if (game.status != GameStatus.completed)
                        Icon(
                          CupertinoIcons.play_arrow_solid,
                          color: game.status == GameStatus.createdNew ? Color(0xFF4DE354) : Colors.white,
                        ),
                      if (game.status == GameStatus.completed)
                        Icon(
                          CupertinoIcons.timer_fill,
                          color: Colors.white,
                        ),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              DateFormat.yMMMMEEEEd().format(game.createdAt),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Champion",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  TextSpan(
                    text: game.champion != null
                        ? "   👑  ${game.getGameChampion(game.champion)?.player.name}  👑"
                        : "  No Champion Yet",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: game.status == GameStatus.completed ? Colors.orange : Color(0xFF4DE354),
                          fontSize: 20,
                        ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                if (game.status == GameStatus.completed)
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Score  ",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        TextSpan(
                          text: game.champion != null
                              ? "${game.getGameChampion(game.champion)?.totalPlayerScore()}"
                              : "--",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.redAccent,
                              ),
                        ),
                      ],
                    ),
                  ),
                if (game.status != GameStatus.completed)
                  Text("Scores", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                const SizedBox(width: 20),
                if (game.status != GameStatus.completed)
                  ...List.generate(game.getGamePlayers().length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Text(
                            game.getGamePlayers()[index].player.name.substring(0, 2),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                          ),
                          Text("--", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.redAccent)),
                          Text(
                            "${game.getGamePlayers()[index].totalPlayerScore()}",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.greenAccent),
                          ),
                        ],
                      ),
                    );
                  }),
                const Spacer(),
                SizedBox(
                  height: 25,
                  child: Row(
                    children: [
                      if (game.status == GameStatus.createdNew)
                        Transform.translate(
                          offset: const Offset(0, 3),
                          child: SizedBox(
                            height: 21,
                            child: Text(
                              "Start",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Color(0xFF4DE354),
                                    // fontSize: 14,
                                  ),
                            ),
                          ),
                        ),
                      if (game.status == GameStatus.paused)
                        Transform.translate(
                          offset: const Offset(0, 3),
                          child: SizedBox(
                            height: 21,
                            child: Text(
                              "Continue",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                    // fontSize: 14,
                                  ),
                            ),
                          ),
                        ),
                      if (game.status == GameStatus.completed)
                        Transform.translate(
                          offset: const Offset(0, 3),
                          child: SizedBox(
                            height: 21,
                            child: Text(
                              "Details",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                    // fontSize: 14,
                                  ),
                            ),
                          ),
                        ),
                      const SizedBox(width: 10),
                      RotatedBox(
                        quarterTurns: 0,
                        child: Icon(
                          CupertinoIcons.forward,
                          size: 18,
                          color: Colors.grey,
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
