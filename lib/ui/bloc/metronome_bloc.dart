import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/core/metronome/metronome.dart';
import 'package:metronome/core/metronome/ui/bloc_event_handler.dart';

class MetronomeBloc extends Bloc<MetronomeEvent, Metronome>
    implements BlockEventHandler {
  MetronomeBloc() : super(Metronome.withDefaultProperties()) {
    registerEventHandler();
  }

  @override
  void registerEventHandler() {
    on<ResumeMetronome>(
      (event, emit) {
        state.resume();
        emit(state);
      },
    );
    on<PauseMetronome>(
      (event, emit) {
        state.pause();
        emit(state);
      },
    );
    on<ChangeMetronomeBpm>(
      (event, emit) {
        state.updateBpm(event.value);
        emit(state);
      },
    );
    on<ChangeMetronomeBeat>(
      (event, emit) {
        state.updateBeat(event.value);
        emit(state);
      },
    );
  }
}

sealed class MetronomeEvent {}

class ResumeMetronome extends MetronomeEvent {}

class PauseMetronome extends MetronomeEvent {}

class ChangeMetronomeBpm extends MetronomeEvent {
  final int value;

  ChangeMetronomeBpm(this.value);
}

class ChangeMetronomeBeat extends MetronomeEvent {
  final int value;

  ChangeMetronomeBeat(this.value);
}
