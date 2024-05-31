import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:lottie/lottie.dart';

class AnimatedHandTouch extends StatefulWidget {
  const AnimatedHandTouch({super.key});

  @override
  State<AnimatedHandTouch> createState() => _AnimatedHandTouch();
}

class _AnimatedHandTouch extends State<AnimatedHandTouch>
    with TickerProviderStateMixin {
  late AnimationController _touchHandController;

  @override
  void initState() {
    super.initState();
    _touchHandController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _touchHandController.reset();
    _touchHandController.forward();
  }

  @override
  void dispose() {
    _touchHandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Semantics(
          label: "Tap the screen to reveal your quote",
          child: Center(
              child: IgnorePointer(
            ignoring: true,
            child: IconButton(
                iconSize: 100,
                onPressed: () {},
                icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.srcATop),
                      child: Lottie.asset(
                        Icons8.tap,
                        controller: _touchHandController,
                      ),
                    ))),
          )),
        ));
  }
}
