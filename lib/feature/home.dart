import 'package:flutter/material.dart';
import 'package:flutter_animation/feature/widgets/standard_bottom_navigation_bar.dart';
import 'package:flutter_animation/feature/widgets/standard_floating_action_buttom.dart';
import 'package:flutter_animation/feature/widgets/standard_page_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 14, 7),
      appBar: AppBar(
        title: const Text('Animation class'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: const StandardFloatingActionButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: StandardBottomNavigationBar(
          currentIndex: currentIndex, onTap: _onTap),
      body: StandardPageView(onPageChanged: _onTap, pageController: _pageController),
    );
  }

  void _onTap(int newIndex) => setState(() {
        currentIndex = newIndex;
        _pageController.animateToPage(newIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastLinearToSlowEaseIn);
      });
}
