import 'dart:async';

import 'package:metronome/core/bpm/bpm_util.dart';

class BpmMeter {
  final StreamController<int> _beatController = StreamController();

  Stream<int> get beatStream => _beatController.stream;
  int _beatInternal = 1;

  int _targetBeat;

  int get targetBeat => _targetBeat;

  int _bpm;

  int get bpm => _bpm;

  late Timer _timer;

  BpmMeter({
    int targetBeat = 4,
    int bpm = 68,
  })  : _bpm = bpm,
        _targetBeat = targetBeat {
    if (_targetBeat < 0) {
      throw const FormatException("Illegal initial beat");
    }
  }

  void resume() {
    _timer = Timer.periodic(
      Duration(milliseconds: BpmUtil.bpmToMillis(_bpm)),
      (timer) => _tick(),
    );
  }

  void _tick() {
    _beatController.add(_calculateBeat());
  }

  int _calculateBeat() {
    if (_beatInternal == _targetBeat) {
      int temp = _beatInternal;
      _beatInternal = 1;
      return temp;
    }
    return _beatInternal++;
  }

  void pause() {
    _timer.cancel();
  }

  bool updateProperty({
    int? bpm,
    int? targetBeat,
  }) {
    try {
      if (bpm != null) {
        _bpm = bpm;
      }
      if (targetBeat != null) {
        _targetBeat = targetBeat;
      }
    } on Exception {
      return false;
    }
    return true;
  }
}
