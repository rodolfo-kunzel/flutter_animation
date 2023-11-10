import 'package:flutter/material.dart';

class StandardBottomNavigationBar extends StatefulWidget {
  const StandardBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});
  final int currentIndex;
  final void Function(int newValue) onTap;

  @override
  State<StandardBottomNavigationBar> createState() =>
      _StandardBottomNavigationBarState();
}

class _StandardBottomNavigationBarState
    extends State<StandardBottomNavigationBar> {
  final _bottomNavigationItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      enableFeedback: true,
      currentIndex: widget.currentIndex,
      items: _bottomNavigationItems,
      backgroundColor: Colors.transparent,
      selectedItemColor: const Color.fromARGB(255, 254, 198, 95),
      unselectedItemColor: Colors.white,
      onTap: (newValue) => widget.onTap(newValue),
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    );
  }
}
