import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hareeg/src/features/games/data/repository/timer.dart';

part 'game_timer_event.dart';

part 'game_timer_state.dart';

class GameTimerBloc extends Bloc<GameTimerEvent, GameTimerState> {
  final Ticker _ticker;
  static const int _duration = 0;

  StreamSubscription<int>? _tickerSubscription;

  GameTimerBloc(Ticker ticker)
      : _ticker = ticker,
        super(GameTimerInitial(_duration)) {
    on<SetTimerInitial>(_onSetStarterTime);

    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);

    on<_TimerTicked>(_onTicked);
  }

  void _onSetStarterTime(SetTimerInitial event, Emitter<GameTimerState> emit) {
    emit(GameTimerInitial(event.duration));
  }

  void _onStarted(TimerStarted event, Emitter<GameTimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: event.duration).listen((duration) => add(_TimerTicked(
          duration: duration,
          gameId: event.gameId,
        )));
  }

  void _onTicked(_TimerTicked event, Emitter<GameTimerState> emit) {
    emit(event.duration > 0 ? TimerRunInProgress(event.duration) : TimerRunComplete());
  }

  void _onPaused(TimerPaused event, Emitter<GameTimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onResumed(TimerResumed resume, Emitter<GameTimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<GameTimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const GameTimerInitial(_duration));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
