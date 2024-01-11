part of 'game_timer_bloc.dart';

abstract class GameTimerEvent {
  const GameTimerEvent();
}

final class TimerStarted extends GameTimerEvent {
  const TimerStarted({required this.duration});

  final int duration;
}

final class TimerPaused extends GameTimerEvent {
  const TimerPaused();
}

final class SetTimerInitial extends GameTimerEvent {
  const SetTimerInitial({required this.duration});

  final int duration;
}

final class TimerResumed extends GameTimerEvent {
  const TimerResumed();
}

class TimerReset extends GameTimerEvent {
  const TimerReset();
}

class _TimerTicked extends GameTimerEvent {
  const _TimerTicked({required this.duration});

  final int duration;
}
