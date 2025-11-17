import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WeatherBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const WeatherBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: Colors.white.withValues(alpha: 0.85),
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.settings),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.listPlus),
            label: '',
          ),
        ],
      ),
    );
  }
}
