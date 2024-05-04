class BpmUtil {
  static int bpmToMillis(int bpm) {
    if (bpm <= 0) {
      throw ArgumentError("BPM must be a positive number.");
    }
    return 60000 ~/ bpm;
  }

  static int millisToBpm(int millis) {
    if (millis <= 0) {
      throw ArgumentError("Millis must be a positive number.");
    }
    return 60000 ~/ millis;
  }
}
