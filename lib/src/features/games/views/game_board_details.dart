import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/views/blocs/game-timer-bloc/game_timer_bloc.dart';
import 'package:hareeg/src/theme/app_theme.dart';

class GameBoardDetailsView extends StatelessWidget {
  const GameBoardDetailsView({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    final duration = context.select((GameTimerBloc bloc) => bloc.state.duration);

    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    final hoursStr = (((duration / 60) / 60) % 60).floor().toString().padLeft(2, '0');

    final mediaQuery = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("${game.status == GameStatus.completed ? "Game Details" : "Playing Cards"}"),
      ),
      body: SizedBox(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (game.status != GameStatus.completed)
              Container(
                height: mediaQuery.height * 0.08,
                width: mediaQuery.width,
                color: Colors.black12,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${hoursStr} : ${minutesStr} : ${secondsStr}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: AppColors.primaryColorHex,
                            ),
                      ),
                    ),
                    GameTimerWidget(),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: GameBoard(game: game),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: mediaQuery.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<GameTimerBloc>().add(const TimerReset());
                  },
                  child: Text("End Game"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameBoard extends StatefulWidget {
  const GameBoard({super.key, required this.game});

  final Game game;

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final List<Color> colors = [
    Colors.blueGrey,
    Colors.deepPurpleAccent,
    Colors.black26,
    AppColors.primaryColorHex,
    Colors.green,
    Colors.deepOrange,
    Colors.blueGrey,
    Colors.deepPurpleAccent,
    Colors.black26,
    AppColors.primaryColorHex,
    Colors.green,
    Colors.deepOrange,
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Row(
          children: [
            ...List.generate(
              widget.game.players.length,
              (index) => Container(
                height: 50,
                width: (mediaQuery.width / widget.game.players.length),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors[index],
                  // borderRadius: BorderRadius.all(
                  //   Radius.circular(10),
                  // ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Center(
                      child: Text(
                        widget.game.players[index].player.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  widget.game.players.length,
                  (pIndex) {
                    final gamePlayers = widget.game.players[pIndex];

                    return Column(
                      children: [
                        if (gamePlayers.playerScore != null)
                          ...List.generate(gamePlayers.playerScore!.rounds!.length, (index) {
                            final round = gamePlayers.playerScore!.rounds;

                            return Container(
                              height: 48,
                              width: (mediaQuery.width / widget.game.players.length),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colors[pIndex].withOpacity(0.5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: LayoutBuilder(builder: (context, constraints) {
                                  return Center(
                                    child: Text(
                                      round![index].score!.toString(),
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          // fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          }),
                        // const SizedBox(height: 10),
                        TotalScoreWidget(
                          color: colors[pIndex],
                          gamePlayerLength: widget.game.players.length,
                          mediaQuery: mediaQuery,
                          gamePlayer: gamePlayers,
                          game: widget.game,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TotalScoreWidget extends StatelessWidget {
  const TotalScoreWidget({
    super.key,
    required this.gamePlayer,
    required this.mediaQuery,
    required this.gamePlayerLength,
    required this.color,
    required this.game,
  });

  final GamePlayer gamePlayer;
  final Size mediaQuery;
  final int gamePlayerLength;
  final Color color;
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: (mediaQuery.width / gamePlayerLength),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: gamePlayer.isFire() ?? false ? Color(0xFFD22323) : color,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: gamePlayer.isFire() ?? false ? Colors.orange : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: Text(
                  gamePlayer.totalPlayerScore().toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              );
            }),
          ),
          if (gamePlayer.isFire() ?? false)
            Positioned(
              top: -25,
              left: -15,
              child: Text(
                "🔥",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(),
              ),
            ),
          if (gamePlayer.isChampion(game) ?? false)
            Positioned(
              top: -20,
              left: -10,
              child: Text(
                "👑",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(),
              ),
            ),
        ],
      ),
    );
  }
}

class GameTimerWidget extends StatelessWidget {
  const GameTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameTimerBloc, GameTimerState>(
      builder: (context, timerState) {
        switch (timerState) {
          case GameTimerInitial():
            return GestureDetector(
              onTap: () {
                context.read<GameTimerBloc>().add(TimerStarted(duration: 5000));
              },
              child: Icon(
                CupertinoIcons.play_arrow_solid,
                color: AppColors.primaryColorHex,
                size: 45,
              ),
            );

          case TimerRunInProgress():
            return GestureDetector(
              onTap: () {
                context.read<GameTimerBloc>().add(const TimerPaused());
              },
              child: Icon(
                Icons.pause,
                color: AppColors.primaryColorHex,
                size: 45,
              ),
            );

          case TimerRunPause():
            return GestureDetector(
              onTap: () {
                context.read<GameTimerBloc>().add(const TimerResumed());
              },
              child: Icon(
                // CupertinoIcons.play_arrow,
                CupertinoIcons.play_arrow_solid,
                color: AppColors.primaryColorHex,
                size: 40,
              ),
            );
          case TimerRunComplete():
            return GestureDetector(
              onTap: () {
                context.read<GameTimerBloc>().add(const TimerReset());
              },
              child: Icon(
                CupertinoIcons.reply,
                color: AppColors.primaryColorHex,
                size: 40,
              ),
            );

          default:
            return GestureDetector(
              onTap: () {
                // context.read<GameTimerBloc>().add(const TimerReset());
              },
              child: Icon(
                CupertinoIcons.delete,
                color: AppColors.primaryColorHex,
                size: 40,
              ),
            );
        }
      },
    );
  }
}
