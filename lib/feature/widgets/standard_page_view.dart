import 'package:flutter/material.dart';
import 'package:flutter_animation/constants/color_constants.dart';
import 'package:flutter_animation/feature/widgets/standard_floating_action_buttom.dart';

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

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  var state = GeoWidgetState.circle();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedAlign(
            duration: const Duration(seconds: 1),
            alignment: state.alignment,
            child: InkWell(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                setState(() {
                  if (state.type == GeoType.circle) {
                    state = GeoWidgetState.square();
                  } else {
                    state = GeoWidgetState.circle();
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: state.heightSize,
                width: state.widthSize,
                decoration: BoxDecoration(
                  color: state.color,
                  borderRadius: BorderRadius.circular(
                    state.radius,
                  ),
                ),
                child: Center(
                  child: AnimatedDefaultTextStyle(
                    style: TextStyle(
                      fontSize: state.fontSize,
                      color: state.fontColor,
                      fontWeight: state.fontWeight,
                    ),
                    duration: const Duration(seconds: 1),
                    child: const Text(
                      'Flutter',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

enum GeoType {
  square,
  circle,
}

class GeoWidgetState {
  final Alignment alignment;
  final double heightSize;
  final double widthSize;
  final Color color;
  final double radius;
  final GeoType type;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;

  GeoWidgetState({
    required this.fontSize,
    required this.fontColor,
    required this.fontWeight,
    required this.color,
    required this.radius,
    required this.type,
    required this.heightSize,
    required this.widthSize,
    required this.alignment,
  });

  factory GeoWidgetState.square() {
    return GeoWidgetState(
      alignment: Alignment.topCenter,
      heightSize: 100,
      widthSize: 200,
      color: ColorConstants.blueSnow,
      radius: 0,
      type: GeoType.square,
      fontColor: ColorConstants.yellowSnow,
      fontSize: 40.0,
      fontWeight: FontWeight.w900,
    );
  }

  factory GeoWidgetState.circle() {
    return GeoWidgetState(
      alignment: Alignment.bottomRight,
      heightSize: 100,
      widthSize: 100,
      color: ColorConstants.yellowSnow,
      radius: 50,
      type: GeoType.circle,
      fontColor: ColorConstants.blueSnow,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) => const Material(
        child: Center(
          child: StandardFloatingActionButtom(),
        ),
      );
}
