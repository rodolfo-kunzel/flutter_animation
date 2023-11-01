import 'dart:ffi';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //used to be able to use the same TickerProvider from the SplashScreen widget

  //declaring the animation controller as late
  late final AnimationController controller;

  //classes created to deal with animation values
  late final Animation<double> text1TranslationAnimation;
  late final Animation<double> text2TranslationAnimation;
  late final Animation<double> lineSizeAnimation;

  @override
  void initState() {
    //initiating the animation controller
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    controller.addListener(
      () {
        print(controller.value);
        setState(() {});
      },
    );

    //Tween are objects that represents animations beeing able to link the previous controller
    text1TranslationAnimation =
        Tween<double>(begin: 34, end: 0).animate(controller);
    text2TranslationAnimation =
        Tween<double>(begin: -22, end: 0).animate(controller);
    lineSizeAnimation =
        Tween<double>(begin: 0, end: 180).animate(controller);

    //called after build method in finished
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.forward();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // we have to dispose the controller once its constantly listening the app
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Transform.translate(
                offset: Offset(0, text1TranslationAnimation.value),
                child: const Text(
                  'Flutterando',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Container(
              width: lineSizeAnimation.value,
              height: 2,
              color: Colors.white,
            ),
            ClipRRect(
              child: Transform.translate(
                offset: Offset(0, text2TranslationAnimation.value),
                child: const Text(
                  'Masterclass',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
