import 'dart:async';

import 'package:metronome/core/metronome/bpm_util.dart';

/// A simple BPM Meter
class Metronome {
  /// Default BPM, based on my heart's
  static const int defaultBpm = 68;

  /// Default target beat
  static const int defaultBeat = 4;

  /// Maximum BPM
  static const int maximumBpm = 218;

  /// Minimum BPM
  static const int minimumBpm = 40;

  /// Maximum beat
  static const int maximumBeat = 16;

  /// Minimum beat
  static const int minimumBeat = 1;

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
    int targetBeat = Metronome.defaultBeat,
    int bpm = Metronome.defaultBpm,
  }) : this(
          properties: MetronomeProperties(
            beat: targetBeat,
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
    if (_beatInternal == properties.beat) {
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
      updateProperties(
        MetronomeProperties(
          bpm: bpm,
          beat: properties.beat,
        ),
      );
    } on Exception {
      return false;
    }
    return true;
  }

  bool updateTargetBeat(int targetBeat) {
    try {
      updateProperties(
        MetronomeProperties(
          bpm: properties.bpm,
          beat: targetBeat,
        ),
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
  final int beat;
  final int bpm;

  MetronomeProperties({
    this.beat = Metronome.defaultBeat,
    this.bpm = Metronome.defaultBpm,
  }) {
    if (beat < Metronome.minimumBeat &&
        beat > Metronome.maximumBeat) {
      throw const FormatException("Target beat must be up to 1.");
    }
    if (bpm < Metronome.minimumBpm && bpm > Metronome.maximumBpm) {
      throw const FormatException("BPM must be up to 1.");
    }
  }
}
