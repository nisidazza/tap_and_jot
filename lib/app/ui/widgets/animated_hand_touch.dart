import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:lottie/lottie.dart';

class AnimatedHandTouch extends StatelessWidget {
  const AnimatedHandTouch(
      {super.key, required this.touchHandController, required this.showQuote});

  final AnimationController touchHandController;
  final VoidCallback showQuote;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Center(
          child: Semantics(
            button: true,
            textDirection: TextDirection.ltr,
            label: 'touch screen icon',
            excludeSemantics: true,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: IconButton(
                  iconSize: 100,
                  onPressed: showQuote,
                  icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcATop),
                        child: Lottie.asset(
                          Icons8.tap,
                          controller: touchHandController,
                        ),
                      ))),
            ),
          ),
        ));
  }
}
