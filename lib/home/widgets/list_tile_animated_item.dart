import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedListViewItem extends StatefulWidget {
  const AnimatedListViewItem(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  State<AnimatedListViewItem> createState() => _AnimatedListViewItemState();
}

class _AnimatedListViewItemState extends State<AnimatedListViewItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> itemHeight;
  late final Animation<Color?> itemColor;
  late final Animation<double> itemIconButtonRotation;

  var isExpanded = false;

  final double _closedItemHeight = 30;
  final double _expandedItemHeight = 100;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    controller.addListener(() {
      setState(() {});
    });

    itemHeight =
        Tween<double>(begin: _closedItemHeight, end: _expandedItemHeight)
            .animate(controller);
    itemIconButtonRotation =
        Tween<double>(begin: pi, end: 0).animate(controller);
    itemColor = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onTap() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isExpanded ? controller.reverse() : controller.forward();
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        color: itemColor.value,
        height: itemHeight.value,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title),
                Transform.rotate(
                  angle: itemIconButtonRotation.value,
                  child: const Icon(Icons.expand_less_rounded),
                ),
              ],
            ),
            if (isExpanded && !controller.isAnimating) ...[
              const SizedBox(height: 10),
              Text(widget.description),
            ],
          ],
        ),
      ),
    );
  }
}
