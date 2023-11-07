import 'package:flutter/material.dart';
import 'package:flutter_animation/data/facts.dart';
import 'package:flutter_animation/feature/widgets/list_tile_animated_item.dart';
import 'package:flutter_animation/feature/widgets/standard_dialog.dart';

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
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context),
        isExtended: true,
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showGeneralDialog<void>(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => const Placeholder(),
      transitionBuilder: (
        BuildContext context,
        Animation<double> a1,
        Animation<double> a2,
        Widget widget,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: _beginDialogOffset,
            end: _endDialogOffset,
          ).animate(CurvedAnimation(parent: a1, curve: Curves.decelerate)),
          child: StandardDialog(
            context: context,
            title: const Text(
              'Curiosities',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
            content: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: facts.length,
              controller: _controller,
              itemBuilder: (context, index) {
                return AnimatedListViewItem(
                    title: facts[index].title,
                    description: facts[index].description);
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
            ),
          ),
        );
      },
    );
  }
}
