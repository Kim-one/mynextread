import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget{
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>{
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;

  void _toggleTimer(){
    if(_isRunning){
      _timer?.cancel();
    } else{
      _timer = Timer.periodic(const Duration(seconds: 1),(timer){
        setState(() {
          _seconds++;
        });
      });
    }

    setState(() {
      _isRunning = !_isRunning;
    });
  }

  String _formatTime(int totalSeconds){
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFFD4A5A5), const Color(0xFFFDF5E6),]
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'SESSION TIMER',
              style: TextStyle(color: Color(0xFF8B4C5A),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.8),
            ),
            const SizedBox(height: 10),
            Text(
              _formatTime(_seconds),
              style: const TextStyle( color: Color(0xFF0F172A),
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Serif'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _toggleTimer,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: Text(_isRunning ? 'PAUSE' : 'START READING', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            const SizedBox(height: 12),
            Text('Record your progress to reach your daily goal.',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 12,
                letterSpacing: 1
              ),
            )
          ],
        )
    );
  }
}