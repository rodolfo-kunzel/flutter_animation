import 'package:flutter/material.dart';
import 'package:flutter_animation/constants/color_constants.dart';
import 'package:flutter_animation/constants/icon_constants.dart';
import 'package:flutter_animation/feature/home/widgets/standard_bottom_navigation_bar.dart';
import 'package:flutter_animation/feature/home/widgets/standard_page_view.dart';
import 'package:flutter_svg/svg.dart';

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
      backgroundColor: ColorConstants.blueSnow,
      appBar: AppBar(
        title: const Text('Animation class'),
        centerTitle: true,
        backgroundColor: ColorConstants.blueSnow,
      ),
      bottomNavigationBar: StandardBottomNavigationBar(
          currentIndex: currentIndex, onTap: _onTap),
      body: StandardPageView(
          onPageChanged: _onTap, pageController: _pageController),
    );
  }

  void _onTap(int newIndex) => setState(() {
        currentIndex = newIndex;
        _pageController.animateToPage(newIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastLinearToSlowEaseIn);
      });
}
