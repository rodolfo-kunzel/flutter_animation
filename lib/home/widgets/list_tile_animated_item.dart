import 'package:flutter/material.dart';

class ListViewAnimatedItem extends StatefulWidget {
  const ListViewAnimatedItem(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  State<ListViewAnimatedItem> createState() => _ListViewAnimatedItemState();
}

class _ListViewAnimatedItemState extends State<ListViewAnimatedItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> itemHeight;
  late final Animation<Color?> itemColor;
  late final Animation<double> itemIconButtonRotation;

  var isExpanded = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    controller.addListener(() {
      setState(() {});
    });

    itemHeight = Tween<double>(begin: 50, end: 100).animate(controller);
    itemColor = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    itemIconButtonRotation = Tween(begin: 1.0, end: 0.5).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onPressed() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      isExpanded ? controller.reverse() : controller.forward();
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: itemColor.value,
      height: itemHeight.value,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.title),
              const Spacer(),
              AnimatedRotation(
                duration: const Duration(seconds: 1),
                turns: itemIconButtonRotation.value,
                child: IconButton(
                  onPressed: _onPressed,
                  icon: const Icon(
                    Icons.expand_less_rounded,
                  ),
                ),
              ),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: 10),
            Text(widget.description),
          ]
        ],
      ),
    );
  }
}
