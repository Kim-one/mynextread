import 'package:flutter/material.dart';

class ContinueReadingCard extends StatelessWidget {
  const ContinueReadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical:8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical:20.0),
            child: Text(
              'Continue Reading',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(48.0),
              border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.55)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(48.0),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/images/book_background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  
                  Padding(
                      padding: const EdgeInsets.all(28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('The Old Man and the Sea', 
                            style: 
                            TextStyle(
                                fontSize: 20, 
                                fontWeight: FontWeight.w900, 
                                fontFamily: 'Serif'
                            ),
                        ),
                        const SizedBox(height: 4,),
                        Text('Ernest Hemingway',
                          style: 
                          TextStyle(color: Colors.pink[800],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 24,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('65% Completed', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            const Text('Page 82 of 127', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        
                        Container(
                          height: 12,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4A5A5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.65,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed:() {},
                          icon: const Icon(Icons.play_circle, color: Colors.white),
                          label: const Text('Continue Reading'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 56),
                            elevation: 8,
                            shadowColor: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}