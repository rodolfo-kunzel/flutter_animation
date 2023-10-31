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
      body: Center(
        child: ListView.builder(
          controller: controller,
          itemCount: items.length,
          itemBuilder: (context, index) => const ListViewAnimatedItem(
            title: 'item 1',
            description: 'item 1',
          ),
        ),
      ),
    );
  }
}
