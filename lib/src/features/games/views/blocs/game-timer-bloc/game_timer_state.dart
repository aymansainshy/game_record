part of 'game_timer_bloc.dart';

abstract class GameTimerState extends Equatable {
  const GameTimerState(this.duration);

  final int duration;

  @override
  List<Object> get props => [duration];
}

class GameTimerInitial extends GameTimerState {
  const GameTimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

final class TimerRunPause extends GameTimerState {
  const TimerRunPause(super.duration);

  @override
  String toString() => 'TimerRunPause { duration: $GameTimerState }';
}

final class TimerRunInProgress extends GameTimerState {
  const TimerRunInProgress(super.duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

final class TimerRunComplete extends GameTimerState {
  const TimerRunComplete() : super(0);
}
