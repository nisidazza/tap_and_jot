import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tap_and_jot/app/models/api_model.dart';

class SingleQuote extends StatelessWidget {
  const SingleQuote(
      {super.key,
      required this.quote,
      required this.shouldDisplay,
      required this.isOpaque});

  final Quote quote;
  final bool shouldDisplay;
  final bool isOpaque;

  getRandomQuote(List<Quote> data) {
    return data[Random().nextInt(data.length)];
  }

  @override
  Widget build(BuildContext context) {
    String? text = quote.text;
    String? authorName = quote.author.split(",").first;
    String author = authorName == "type.fit" ? "" : authorName;
    return SafeArea(
        child: DefaultTextStyle(
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: AnimatedOpacity(
            opacity: isOpaque ? 1.0 : 0.0,
            duration: const Duration(seconds: 2),
            child: shouldDisplay
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: GoogleFonts.badScript().fontFamily,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontSize: 40,
                          )),
                      const SizedBox(height: 10),
                      Text(author),
                    ],
                  )
                : const Scaffold(
                    backgroundColor: Colors.transparent,
                  )),
      ),
    ));
  }
}
