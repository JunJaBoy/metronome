import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/core/metronome/metronome.dart';
import 'package:metronome/core/metronome/ui/bloc_event_handler.dart';

class MetronomeBloc extends Bloc<MetronomeEvent, Metronome>
    implements BlockEventHandler {
  MetronomeBloc() : super(Metronome.withDefaultProperties()) {
    registerEventHandler();
  }

  @override
  void registerEventHandler() => on<MetronomeEvent>(
        (event, emit) {
          switch (event) {
            case ResumeMetronome():
              state.resume();
              emit(state);
              break;
            case PauseMetronome():
              state.pause();
              emit(state);
              break;
            case ChangeMetronomeProperties():
          }
        },
      );
}

sealed class MetronomeEvent {}

class ResumeMetronome extends MetronomeEvent {}

class PauseMetronome extends MetronomeEvent {}

class ChangeMetronomeProperties extends MetronomeEvent {}
