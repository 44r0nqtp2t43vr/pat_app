import 'dart:async';

import 'package:flutter/material.dart';

class AppTimer extends StatefulWidget {
  const AppTimer({super.key});

  @override
  State<AppTimer> createState() => _AppTimerState();
}

class _AppTimerState extends State<AppTimer> {
  late Timer _timer;
  String _currentTime = "";

  @override
  void initState() {
    _currentTime = _getCurrentTime();
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _getCurrentTime();
      });
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.year}/${_twoDigits(now.month)}/${_twoDigits(now.day)} '
        '${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}';
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTime,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
