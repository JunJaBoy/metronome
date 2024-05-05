import 'dart:async';

import 'package:metronome/core/metronome/bpm_util.dart';

/// A simple BPM Meter
class Metronome {
  /// Default BPM, based on my heart's
  static const int defaultBpm = 68;

  /// Default target beat
  static const int defaultTargetBeat = 4;

  /// Stream controller for BPM
  final StreamController<int?> _beatController = StreamController();

  /// Stream from [_beatController]
  Stream<int?> get beatStream => _beatController.stream;

  /// Internal beat count for [beatStream]
  int _beatInternal = 1;

  /// BPM Properties, contains BPM and target beat
  MetronomeProperties properties = MetronomeProperties();

  Timer? _timer;

  var _isPlaying = false;

  bool get isPlaying => _isPlaying;

  Metronome({
    required this.properties,
  });

  Metronome.withDefaultProperties({
    int targetBeat = Metronome.defaultTargetBeat,
    int bpm = Metronome.defaultBpm,
  }) : this(
          properties: MetronomeProperties(
            targetBeat: targetBeat,
            bpm: bpm,
          ),
        );

  void resume() {
    // invokes before the timer tick begins
    _tick();
    _timer = Timer.periodic(
      Duration(milliseconds: BpmUtil.bpmToMillis(properties.bpm)),
      (timer) => _tick(),
    );
    _isPlaying = true;
  }

  void _tick() {
    _beatController.add(_calculateBeat());
  }

  int _calculateBeat() {
    if (_beatInternal == properties.targetBeat) {
      int temp = _beatInternal;
      _beatInternal = 1;
      return temp;
    }
    return _beatInternal++;
  }

  void pause() {
    _timer?.cancel();
    _beatController.add(null);
    _beatInternal = 1;
    _isPlaying = false;
  }

  bool updateBpm(int bpm) {
    try {
      properties = MetronomeProperties(
        bpm: bpm,
        targetBeat: properties.targetBeat,
      );
    } on Exception {
      return false;
    }
    return true;
  }

  bool updateTargetBeat(int targetBeat) {
    try {
      properties = MetronomeProperties(
        bpm: properties.bpm,
        targetBeat: targetBeat,
      );
    } on Exception {
      return false;
    }
    return true;
  }

  bool updateProperties(MetronomeProperties properties) {
    try {
      properties = properties;
    } on Exception {
      return false;
    }
    return true;
  }
}

class MetronomeProperties {
  final int targetBeat;
  final int bpm;

  MetronomeProperties({
    this.targetBeat = Metronome.defaultTargetBeat,
    this.bpm = Metronome.defaultBpm,
  }) {
    if (targetBeat < 1) {
      throw const FormatException("Target beat must be up to 1.");
    }
    if (bpm < 1) {
      throw const FormatException("BPM must be up to 1.");
    }
  }
}
