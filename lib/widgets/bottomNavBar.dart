import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget{
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_filled, 0),
                _buildNavItem(Icons.menu_book, 1),
                _buildNavItem(Icons.face, 2),
              ],
            )
        )
    );
  }

  Widget _buildNavItem(IconData icon, int index){
    bool isActive = selectedIndex == index;

    return IconButton(
      enableFeedback: false,
        onPressed: () =>
        onTap(index),
        icon: Icon(
          icon,
          size: 30,
            color: isActive ? Colors.pink : Colors.pink.withValues(alpha: 0.5),
        )
    );
  }
}