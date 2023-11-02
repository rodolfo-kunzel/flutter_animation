import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animation/data/facts.dart';
import 'package:flutter_animation/home/widgets/list_tile_animated_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = ScrollController();

  final _endDialogOffset = Offset.zero;
  final _beginDialogOffset = const Offset(0.0, 1.5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation class'),
        titleSpacing: 10,
        centerTitle: true,
        toolbarOpacity: 0.5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context),
        isExtended: true,
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final dialogHeight = MediaQuery.of(context).size.height * 0.4;
    final dialogWidth = MediaQuery.of(context).size.height * 0.8;

    return showGeneralDialog<void>(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => const Placeholder(),
      transitionBuilder: (BuildContext context, Animation<double> a1,
              Animation<double> a2, Widget widget) =>
          SlideTransition(
        position: Tween<Offset>(
          begin: _beginDialogOffset,
          end: _endDialogOffset,
        ).animate(CurvedAnimation(parent: a1, curve: Curves.decelerate)),
        child: Dialog(
          child: Container(
            width: dialogWidth,
            height: dialogHeight,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: ListView.builder(
              controller: _controller,
              itemCount: facts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => AnimatedListViewItem(
                title: facts[index].title,
                description: facts[index].description,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
