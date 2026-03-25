import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget{
  final IconData icon;
  final String value;
  final String unit;
  final String label;

  const SummaryCard({
    super.key,
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded (
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal:16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF5F5),
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pink.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFFE57373),
                  size: 24.0,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Serif',
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    unit, 
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF8B4C5A).withValues(alpha: 0.6),
                ),
              )
            ],
          )
      )
    );
  }
}