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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: mediaQuery.height * 0.10,
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
                            color: Colors.black45,
                          ),
                    ),
                  ),
                  BlocBuilder<GameTimerBloc, GameTimerState>(
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
                  ),
                ],
              ),
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
