import 'package:flutter/material.dart';

class StandardDialog extends StatelessWidget {
  const StandardDialog(
      {super.key,
      required this.content,
      required this.title,
      required this.context});
  final BuildContext context;
  final Widget content;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.4;
    final width = MediaQuery.of(context).size.width * 0.8;

    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      title: title,
      content: SizedBox(
        height: height,
        width: width,
        child: content,
      ),
    );
  }
}
