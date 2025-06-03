import 'package:flutter/material.dart';
import 'package:med_notifications/widgets/bottom_nav.dart';
import 'medicamento_screen.dart';
import 'placeholder_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    PlaceholderScreen(title: 'Hoy'),
    MedicamentoScreen(),
    PlaceholderScreen(title: 'Más'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
