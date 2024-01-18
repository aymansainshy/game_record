import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/views/blocs/game-timer-bloc/game_timer_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/games-bloc/games_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/save-game-locally-bloc/save_game_locally_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/sigle-game-bloc/single_game_bloc.dart';
import 'package:hareeg/src/features/games/views/widgets/add_new_player_to_current_game_sheet.dart';
import 'package:hareeg/src/features/games/views/widgets/add_new_record_dialog.dart';
import 'package:hareeg/src/features/games/views/widgets/game_timer_widget.dart';
import 'package:hareeg/src/features/games/views/widgets/total_score_widget.dart';
import 'package:hareeg/src/theme/app_theme.dart';
import 'package:intl/intl.dart';

class GameBoardDetailsView extends StatelessWidget {
  const GameBoardDetailsView({
    super.key,
    required this.game,
  });

  final Game game;

  String gameStatusTextWidget(GameStatus status) {
    String text = " ";

    if (status == GameStatus.createdNew) {
      text = "Start Playing";
    } else if (status == GameStatus.currentPlaying) {
      text = "Playing ...";
    } else if (status == GameStatus.paused) {
      text = "Game Paused";
    } else if (status == GameStatus.completed) {
      text = "Game Details";
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    final duration = context.select((GameTimerBloc bloc) => bloc.state.duration);

    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    final hoursStr = (((duration / 60) / 60) % 60).floor().toString().padLeft(2, '0');

    final mediaQuery = MediaQuery.sizeOf(context);

    final savingStatus = context.select((SaveGameLocallyBloc bloc) => bloc.state);

    return BlocBuilder<SingleGameBloc, SingleGameState>(
      builder: (context, singleGameState) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).colorScheme.background,
              title: BlocBuilder<SaveGameLocallyBloc, SaveGameLocallyState>(
                builder: (context, savingState) {
                  if (savingState is SavingGameInProgress) {
                    return Text("Saving game status ...");
                  }
                  return Text(gameStatusTextWidget(game.status));
                },
              ),
              leading: IconButton(
                onPressed: savingStatus is SavingGameInProgress
                    ? null
                    : () async {
                        if (game.status == GameStatus.currentPlaying) {
                          final bool result = await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return BlocConsumer<SaveGameLocallyBloc, SaveGameLocallyState>(
                                  listener: (context, savingState) {
                                    if (savingState is SavingGameFailure) {
                                      Navigator.of(context).pop(false);
                                    }
                                    if (savingState is SavingGameSuccess) {
                                      Navigator.of(context).pop(true);
                                    }
                                  },
                                  builder: (context, savingState) {
                                    return AlertDialog(
                                      title: Text("Save Game status before exit."),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // TODO: save game status
                                            context.read<GameTimerBloc>().add(const TimerPaused());
                                            context
                                                .read<SingleGameBloc>()
                                                .add(UpdateGameDuration(game: game, duration: duration));

                                            context.read<SaveGameLocallyBloc>().add(SaveGameStatus(game: game));
                                          },
                                          child: Text(
                                            "${savingState is SavingGameInProgress ? "Saving status ...." : "Save game status & Exit"}",
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.red,
                                                ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text("Continue playing"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              });

                          if (result) {
                            context.read<GamesBloc>().add(GetAllGames());
                            Navigator.of(context).pop();
                          }
                        } else {
                          context.read<GamesBloc>().add(GetAllGames());
                          Navigator.of(context).pop();
                        }
                      },
                icon: Platform.isAndroid ? Icon(Icons.arrow_back) : Icon(CupertinoIcons.back),
              ),
            ),
            body: SizedBox(
              height: mediaQuery.height,
              width: mediaQuery.width,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (game.status == GameStatus.completed)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                        child: Text(
                          DateFormat.yMMMMEEEEd().format(game.createdAt),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.black45,
                                // fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
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
                            GameTimerWidget(game: game),
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
                        child: Row(
                          children: [
                            if (game.status == GameStatus.paused || game.status == GameStatus.createdNew)
                              Expanded(child: SizedBox.shrink()),
                            if (game.status == GameStatus.paused || game.status == GameStatus.createdNew)
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.zero,
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        // side: BorderSide(color: Colors.red)
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (game.isContainFiredPerson()) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("You can't add new Players, the game contains 🔥persons"),
                                          duration: Duration(milliseconds: 1000),
                                        ),
                                      );
                                      return;
                                    }

                                    if (game.getGamePlayers().length >= 6) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("You can't add new Players, Max is 6 Players"),
                                          duration: Duration(milliseconds: 1000),
                                        ),
                                      );
                                      return;
                                    }

                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return AddNewPlayerToCurrentGameSheet(game: game);
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Add Player to game"),
                                      Icon(CupertinoIcons.person_add_solid),
                                    ],
                                  ),
                                ),
                              ),
                            if (game.status == GameStatus.currentPlaying) Expanded(child: SizedBox.shrink()),
                            if (game.status == GameStatus.currentPlaying)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddNewRecordDialog(
                                          game: game,
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Add Record"),
                                      Icon(Icons.edit_calendar_outlined),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
    Colors.black,
    AppColors.primaryColorHex,
    Colors.green,
    Colors.deepOrange,
    Colors.blueGrey,
    Colors.deepPurpleAccent,
    Colors.black,
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
              widget.game.getGamePlayers().length,
              (index) => Container(
                height: 50,
                width: (mediaQuery.width / widget.game.getGamePlayers().length),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Center(
                      child: Text(
                        widget.game.getGamePlayers()[index].player.name,
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
        // SizedBox(height: 5),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  widget.game.getGamePlayers().length,
                  (pIndex) {
                    final gamePlayers = widget.game.getGamePlayers()[pIndex];

                    return Column(
                      children: [
                        ...List.generate(gamePlayers.getPlayerScores().length, (index) {
                          final scoresList = gamePlayers.getPlayerScores();

                          return Container(
                            height: 48,
                            width: (mediaQuery.width / widget.game.getGamePlayers().length),
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: colors[pIndex].withOpacity(0.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: LayoutBuilder(builder: (context, constraints) {
                                return Center(
                                  child: Text(
                                    scoresList[index].toString(),
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
                          gamePlayerLength: widget.game.getGamePlayers().length,
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
