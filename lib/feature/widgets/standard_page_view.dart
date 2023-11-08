import 'package:flutter/material.dart';

class StandardPageView extends StatefulWidget {
  const StandardPageView(
      {super.key, required this.pageController, required this.onPageChanged});
  final PageController pageController;
  final void Function(int newIndex) onPageChanged;

  @override
  State<StandardPageView> createState() => _StandardPageViewState();
}

class _StandardPageViewState extends State<StandardPageView> {
  final List<Widget> _children = const [PageOne(), PageTwo(), PageThree()];

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.pageController,
      children: _children,
      onPageChanged: (newIndex) => widget.onPageChanged(newIndex),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) =>
      Image.asset('assets/images/sunset_one.jpg');
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) =>
      Image.asset('assets/images/sunset_two.jpg');
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) =>
      Image.asset('assets/images/sunset_three.jpg');
}
