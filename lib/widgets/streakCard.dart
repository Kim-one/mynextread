import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class StreakWidget extends StatefulWidget {
  const StreakWidget({super.key});

  @override
  State<StreakWidget> createState() => _StreakCard();
}

class _StreakCard extends State<StreakWidget>{
  // const StreakCard({super.key});
  final StorageService storageService = StorageService();
  int streak = 0;

  @override
  void initState(){
    super.initState();
    loadStreak();
  }

  Future<void> loadStreak() async{
    final savedStreak = await storageService.getReadingStreak();
    setState((){
      streak = savedStreak;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [const Color(0xFFD4A5A5), const Color(0xFFFDF5E6),]
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10)
              )
            ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Stack(
            children: [
              Positioned(
                right: -24,
                bottom: -24,
                child: Opacity(
                  opacity: 0.1,
                  child: Icon(
                    Icons.menu_book,
                    size: 160,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('CURRENT STREAK',
                        style: TextStyle(
                            color: const Color(0xFF8B4C5A),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.8
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('$streak Days',
                            style: TextStyle(
                                color: const Color(0xFF0F172A),
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Serif'
                            ),
                          ),
                          const SizedBox(width: 12,),
                          const Icon(
                            Icons.auto_awesome,
                            color: Colors.pink,
                            size: 30,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(streak==0
                          ? "Start your streak today! "
                          : "You're on fire! Keep it up, bookworm",
                        style: TextStyle(
                          color: const Color(0xFF8B4C5A).withValues(alpha: 0.7),
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}