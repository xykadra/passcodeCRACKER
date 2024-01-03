import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passcodecr/stateManagement/variables.dart';

class CountdownTimer extends StatefulWidget {
  final Function(bool) isTimerOver;
  const CountdownTimer({required this.isTimerOver, super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            widget.isTimerOver(true);
            Variables.stopTimerExtremeMode();
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Variables.getTimerStatus());
    if (Variables.getTimerStatus()) {
      startTimer();
    }
    return Container(
      height: 40,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          "$_start",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
