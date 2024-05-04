abstract interface class BlockEventHandler {
  /// [registerEventHandler] must be called inside the [onEvent] of the Bloc
  void registerEventHandler();
}
