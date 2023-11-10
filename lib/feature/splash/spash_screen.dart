import 'package:flutter/material.dart';
import 'package:flutter_animation/constants/color_constants.dart';
import 'package:flutter_animation/constants/icon_constants.dart';
import 'package:flutter_animation/feature/home/home.dart';
import 'package:flutter_svg/svg.dart';

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
  late final Animation<double> titleTranslationAnimation;
  late final Animation<double> subtitleTranslationAnimation;
  late final Animation<double> logoTranslationAnimation;
  late final Animation<double> lineSizeAnimation;
  // late final Animation<double> logoOpacityAnimation;

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
    controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.dismissed && controller.value == 0) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const Home(),
              transitionDuration: const Duration(seconds: 1),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
        }
      },
    );

    //Tween are objects that represents animations beeing able to link the previous controller with different intervals
    titleTranslationAnimation = Tween<double>(begin: 34, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.85, curve: Curves.easeInOutCubic),
      ),
    );
    subtitleTranslationAnimation = Tween<double>(begin: -25, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.85, curve: Curves.easeInOutCubic),
      ),
    );
    logoTranslationAnimation = Tween<double>(begin: -400, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.85, curve: Curves.easeInOutCubic),
      ),
    );

    // Opacity example
    // logoOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
    //   CurvedAnimation(
    //     parent: controller,
    //     curve: const Interval(0.25, 0.85, curve: Curves.decelerate),
    //   ),
    // );
    
    //animation to controll sequence of line movement
    lineSizeAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0, end: 250)
              .chain(CurveTween(curve: Curves.easeInOutCubic)),
          weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: 250, end: 250), weight: 60),
      TweenSequenceItem(tween: Tween<double>(begin: 250, end: 0), weight: 15),
    ]).animate(controller);

    //called after build method in finished
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.animateTo(0.85).whenComplete(() {
          controller.repeat(min: 0.8, max: 1.0, reverse: true);
          Future.wait([
            //array of future actions to be completed until animation finish
            backdroundAction(),
          ]).whenComplete(() => controller.reverse());
        });
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
            Stack(
              children: [
                Transform.translate(
                  offset: Offset(logoTranslationAnimation.value, 0),
                  child: SvgPicture.asset(
                    IconConstants.logo2Snow,
                    height: 100,
                  ),
                ),
                Hero(
                  tag: 'logo',
                  // child: Opacity(
                  //   opacity: logoOpacityAnimation.value,
                    child: SvgPicture.asset(
                      IconConstants.logoSnow,
                      height: 100,
                    ),
                  // ),
                ),
              ],
            ),
            const SizedBox(
              height: 150,
            ),
            ClipRRect(
              child: Transform.translate(
                offset: Offset(0, titleTranslationAnimation.value),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w900,
                    color: ColorConstants.yellowSnow,
                  ),
                ),
              ),
            ),
            Container(
              width: lineSizeAnimation.value,
              height: 4,
              decoration: BoxDecoration(
                color: ColorConstants.whiteSnow,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ClipRRect(
              child: Transform.translate(
                offset: Offset(0, subtitleTranslationAnimation.value),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w900,
                    color: ColorConstants.yellowSnow,
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
