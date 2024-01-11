import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/features/games/views/blocs/game-timer-bloc/game_timer_bloc.dart';
import 'package:hareeg/src/theme/app_theme.dart';

class GameBoardDetailsView extends StatelessWidget {
  const GameBoardDetailsView({super.key});

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
      ),
      body: SizedBox(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${hoursStr} : ${minutesStr} : ${secondsStr}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.black45,
                  ),
            ),
            BlocBuilder<GameTimerBloc, GameTimerState>(
              builder: (context, timerState) {
                switch (timerState) {
                  case GameTimerInitial():
                    return GestureDetector(
                      onTap: () {
                        context.read<GameTimerBloc>().add(TimerStarted(duration: 60));
                      },
                      child: Icon(
                        CupertinoIcons.play_arrow_solid,
                        color: AppColors.primaryColorHex,
                      ),
                    );

                  case TimerRunInProgress():
                    return GestureDetector(
                      onTap: () {
                        context.read<GameTimerBloc>().add(const TimerPaused());
                      },
                      child: Icon(
                        CupertinoIcons.pause,
                        color: AppColors.primaryColorHex,
                      ),
                    );

                  case TimerRunPause():
                    return GestureDetector(
                      onTap: () {
                        context.read<GameTimerBloc>().add(const TimerResumed());
                      },
                      child: Icon(
                        CupertinoIcons.play_arrow,
                        color: AppColors.primaryColorHex,
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
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
