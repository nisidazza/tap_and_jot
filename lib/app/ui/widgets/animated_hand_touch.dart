import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tap_and_jot/app/providers/quotes_provider.dart';

class AnimatedHandTouch extends StatefulWidget {
  const AnimatedHandTouch({super.key});

  @override
  State<AnimatedHandTouch> createState() => _AnimatedHandTouchState();
}

class _AnimatedHandTouchState extends State<AnimatedHandTouch>
    with TickerProviderStateMixin {
  late AnimationController touchHandController;

  @override
  void initState() {
    super.initState();
    touchHandController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    touchHandController.reset();
    touchHandController.forward();
  }

  @override
  void dispose() {
    touchHandController.dispose();
    super.dispose();
  }

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
                child: Consumer<QuotesProvider>(
                    builder: (context, provider, child) {
                  return IconButton(
                      iconSize: 100,
                      onPressed: provider.showQuoteOnTap,
                      icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcATop),
                            child: Lottie.asset(
                              Icons8.tap,
                              controller: touchHandController,
                            ),
                          )));
                })),
          ),
        ));
  }
}
