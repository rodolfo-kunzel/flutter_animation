import 'package:flutter/material.dart';
import 'package:flutter_animation/constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';

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

  final String title = 'Snowman Labs';
  final String subtitle = 'Flutter Stack Meeting';

  @override
  void initState() {
    //initiating the animation controller
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    //state management tool
    controller.addListener(
      () {
        setState(() {});
      },
    );

    //end of animation trigger
    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed && controller.value == 0) {
        // ignore: avoid_print
        print('Navigation.pushNamed("/home")');
      }
    });

    //Tween are objects that represents animations beeing able to link the previous controller with different intervals
    text1TranslationAnimation = Tween<double>(begin: 34, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.85, curve: Curves.easeOutBack),
      ),
    );
    text2TranslationAnimation = Tween<double>(begin: -25, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.85, curve: Curves.easeOutBack),
      ),
    );
    //animation to controll sequence of line movement
    lineSizeAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: 180)
              .chain(CurveTween(curve: Curves.decelerate)),
          weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: 180, end: 180), weight: 60),
      TweenSequenceItem(tween: Tween<double>(begin: 180, end: 0), weight: 15),
    ]).animate(controller);

    //called after build method in finished
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.animateTo(0.85).whenComplete(
              () => controller.repeat(min: 0.8, max: 1.0, reverse: true),
            );
        Future.wait([
          //array of future actions to be completed until animation finish
          backdroundAction(),
        ]).whenComplete(() => controller.reverse());
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

  //fake delay to represent some backdround action
  Future<void> backdroundAction() async {
    await Future.delayed(const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstants.blueSnow,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Transform.translate(
                offset: Offset(0, text1TranslationAnimation.value),
                child: Text(
                  title,
                  style: GoogleFonts.rubik(
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
                child: Text(
                  subtitle,
                  style: GoogleFonts.rubik(
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
