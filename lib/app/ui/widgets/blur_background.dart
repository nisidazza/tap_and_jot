import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackground extends StatelessWidget {
  const BlurBackground({
    super.key,
    required this.shouldDisplay,
  });

  final bool shouldDisplay;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
          sigmaX: 10.0, sigmaY: 10.0, tileMode: TileMode.decal),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        decoration: shouldDisplay
            ? BoxDecoration(
                color: Colors.black54,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.transparent, width: 3.0),
              )
            : null,
      ),
    );
  }
}
