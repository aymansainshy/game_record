import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/features/games/data/model/game_model.dart';
import 'package:hareeg/src/features/games/views/blocs/game-timer-bloc/game_timer_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/save-game-locally-bloc/save_game_locally_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/sigle-game-bloc/single_game_bloc.dart';
import 'package:hareeg/src/theme/app_theme.dart';

class GameTimerWidget extends StatelessWidget {
  const GameTimerWidget({super.key, required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameTimerBloc, GameTimerState>(
      builder: (context, timerState) {
        switch (timerState) {
          case GameTimerInitial():
            return GestureDetector(
              onTap: () {
                context.read<GameTimerBloc>().add(TimerStarted(
                      duration: game.getGameDuration(),
                      gameId: game.id,
                    ));
                context.read<SingleGameBloc>().add(UpdateGameStatus(game: game, status: GameStatus.currentPlaying));
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
                context.read<SingleGameBloc>().add(UpdateGameDuration(game: game, duration: timerState.duration));
                context.read<SingleGameBloc>().add(UpdateGameStatus(game: game, status: GameStatus.paused));

                // To Save game status locally when paused ...
                context.read<SaveGameLocallyBloc>().add(SaveGameStatus(game: game));
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
                context.read<SingleGameBloc>().add(UpdateGameStatus(game: game, status: GameStatus.currentPlaying));
              },
              child: Icon(
                CupertinoIcons.play_arrow,
                // CupertinoIcons.play_arrow_solid,
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
