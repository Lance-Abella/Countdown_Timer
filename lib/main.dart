// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: CountdownTimerDemo(),
  ));
}

class CountdownTimerDemo extends StatefulWidget {
  const CountdownTimerDemo({super.key});

  @override
  _CountdownTimerDemoState createState() => _CountdownTimerDemoState();
}

class _CountdownTimerDemoState extends State<CountdownTimerDemo> {
  late Timer _timer;
  int _endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60; 
  int _currentTime = 1000 * 60;
  bool _isTimerRunning = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTime > 0) {
          _currentTime -= 1000;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void _pauseTimer() {
    _timer.cancel();
  }

  void _toggleTimer() {
    setState(() {
      _isTimerRunning = !_isTimerRunning;
      if (_isTimerRunning) {
        _startTimer();
      } else {
        _pauseTimer();
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _currentTime = 1000 * 60;
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
      _endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
      _pauseTimer();
      _resetTimer();
    });
  }

  String _formatDuration(int duration) {
    Duration d = Duration(milliseconds: duration);
    return '${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _formatDuration(_currentTime),
          style: const TextStyle(fontSize: 48),
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _toggleTimer,
            child: Icon(_isTimerRunning ? Icons.pause : Icons.play_arrow),
          ),

          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _stopTimer,
            child: const Icon(Icons.stop),
          ),

          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: _resetTimer,
            child: const Icon(Icons.refresh),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
