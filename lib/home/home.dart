import 'package:flutter/material.dart';
import 'package:flutter_animation/home/widgets/list_tile_animated_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Map items = <String, String>{
    'item 1': 'Description 1',
    'item 2': 'Descruption 2',
    'item 3': 'Description 3',
    'item 4': 'Description 4',
    'item 5': 'Descruition 5',
    'item 6': 'Description 6',
    'item 7': 'Description 7',
    'item 8': 'Description 8',
    'item 9': 'Description 9',
    'item 10': 'Descrition 10',
    'item 11': 'Description 11',
    'item 12': 'Description 12',
    'item 13': 'Description 13',
    'item 14': 'Description 14',
    'item 15': 'Description 15',
    'item 16': 'Description 16',
  };

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation class'),
        titleSpacing: 10,
        centerTitle: true,
        toolbarOpacity: 0.5,
      ),
      backgroundColor: Colors.yellowAccent,
      floatingActionButton:
          FloatingActionButton(onPressed: () => _dialogBuilder(context)),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
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
          begin: const Offset(0.0, 1.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: a1, curve: Curves.decelerate)),
        child: Dialog(
          child: Container(
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 800),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: ListView.builder(
              controller: controller,
              itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => const AnimatedListViewItem(
                title: 'item 1',
                description: 'item 1',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
