class Variables {
  static bool startTimer = false;

  static void startTimerExtremeMode() {
    startTimer = true;
  }

  static void stopTimerExtremeMode() {
  startTimer = false;
  }

  static bool getTimerStatus() {
    return startTimer;
  }
}
