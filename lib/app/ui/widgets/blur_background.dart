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
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
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
