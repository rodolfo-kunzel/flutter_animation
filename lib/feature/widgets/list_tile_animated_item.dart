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
    _itemColor = ColorTween(
      begin: const Color.fromARGB(255, 255, 219, 151),
      end: const Color.fromARGB(255, 254, 198, 95),
    ).animate(_controller);
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
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: _itemColor.value),
        child: Align(
          heightFactor: 1,
          alignment: Alignment.topCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AnimatedCrossFade(
                  duration:
                      Duration(milliseconds: _animationDurationInMiliseconds),
                  firstChild: FirstChild(title: widget.title),
                  secondChild: SecondChild(
                      title: widget.title, description: widget.description),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, right: 8),
                child: Transform.rotate(
                  angle: _itemIconButtonRotation.value,
                  child: const Icon(Icons.expand_less_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstChild extends StatelessWidget {
  const FirstChild({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class SecondChild extends StatelessWidget {
  const SecondChild(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(description, textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}
