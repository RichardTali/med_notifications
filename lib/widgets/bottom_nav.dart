import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Hoy'),
        BottomNavigationBarItem(icon: Icon(Icons.medication), label: 'Medicamento'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Más'),
      ],
    );
  }
}
