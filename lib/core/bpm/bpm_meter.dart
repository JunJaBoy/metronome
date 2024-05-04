import 'dart:async';

import 'package:metronome/core/bpm/bpm_util.dart';

class BpmMeter {
  static const int defaultBpm = 68;
  static const int defaultTargetBeat = 4;

  final StreamController<int> _beatController = StreamController();

  Stream<int> get beatStream => _beatController.stream;

  int _beatInternal = 1;

  int _targetBeat;

  int get targetBeat => _targetBeat;

  int _bpm;

  int get bpm => _bpm;

  Timer? _timer;

  var _isPlaying = false;

  bool get isPlaying => _isPlaying;

  BpmMeter({
    int targetBeat = BpmMeter.defaultTargetBeat,
    int bpm = BpmMeter.defaultBpm,
  })  : _bpm = bpm,
        _targetBeat = targetBeat {
    if (_targetBeat <= 0) {
      throw const FormatException("Illegal initial beat");
    }
  }

  void resume() {
    _timer = Timer.periodic(
      Duration(milliseconds: BpmUtil.bpmToMillis(_bpm)),
      (timer) => _tick(),
    );
    _isPlaying = true;
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
    _timer?.cancel();
    _isPlaying = false;
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
