/*
abstract class BpmMeter {
  int beat;
  Stream<int> bpmStream;

  BpmMeter({
    required this.beat,
    required this.bpmStream,
  });

  void play();

  void pause();
}

class BpmMeterImpl extends BpmMeter {
  BpmMeterImpl(int beat)
      : super(
          beat: beat,
          bpmStream: Stream.empty(),
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BpmMeterImpl &&
          runtimeType == other.runtimeType &&
          beat == other.beat;
}
*/
