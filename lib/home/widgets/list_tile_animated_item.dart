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
  late final AnimationController _controller;
  late final Animation<Color?> _itemColor;
  late final Animation<double> _itemIconButtonRotation;

  final _animationDurationInMiliseconds = 400;

  var _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: _animationDurationInMiliseconds));

    _controller.addListener(() {
      setState(() {});
    });

    _itemIconButtonRotation =
        Tween<double>(begin: pi, end: 0).animate(_controller);
    _itemColor = ColorTween(begin: Colors.blueGrey, end: Colors.black)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _isExpanded ? _controller.reverse() : _controller.forward();
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Align(
        heightFactor: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: AnimatedCrossFade(
                duration:
                    Duration(milliseconds: _animationDurationInMiliseconds),
                firstChild: Text(widget.title),
                secondChild: Text(widget.description),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ),
            Transform.rotate(
              angle: _itemIconButtonRotation.value,
              child: const Icon(Icons.expand_less_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
