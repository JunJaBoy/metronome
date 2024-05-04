import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/core/bpm/bpm_meter.dart';
import 'package:metronome/ui/core/ui/bloc_event_handler.dart';

class BpmMeterBloc extends Bloc<BpmMeterEvent, BpmMeter>
    implements BlockEventHandler {
  var isPlaying = false;

  BpmMeterBloc() : super(BpmMeter()) {
    registerEventHandler();
  }

  @override
  void registerEventHandler() => on<BpmMeterEvent>(
        (event, emit) {
          switch (event) {
            case ResumeMetronome():
              isPlaying = true;
              state.resume();
              break;
            case PauseMetronome():
              isPlaying = false;
              state.pause();
              break;
          }
        },
      );
}

sealed class BpmMeterEvent {}

class ResumeMetronome extends BpmMeterEvent {}

class PauseMetronome extends BpmMeterEvent {}
