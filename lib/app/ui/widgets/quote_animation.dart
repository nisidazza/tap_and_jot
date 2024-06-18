import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tap_and_jot/app/models/api_model.dart';

class QuoteAnimation extends StatelessWidget {
  const QuoteAnimation(
      {super.key,
      required this.quote,
      required this.shouldDisplay,
      required this.isOpaque});

  final Quote quote;
  final bool shouldDisplay;
  final bool isOpaque;

  @override
  Widget build(BuildContext context) {
    String? text = quote.text;
    String? authorName = quote.author.split(",").first;
    String author = authorName == "type.fit" ? "" : authorName;
    return DefaultTextStyle(
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: AnimatedOpacity(
            opacity: isOpaque ? 1.0 : 0.0,
            duration: const Duration(seconds: 2),
            child: Visibility(
              visible: shouldDisplay,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Semantics(
                    label: text,
                    excludeSemantics: true,
                    textDirection: TextDirection.ltr,
                    child: Text(text,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: GoogleFonts.badScript().fontFamily,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 40,
                        )),
                  ),
                  const SizedBox(height: 10),
                  Semantics(
                    label: author,
                    excludeSemantics: true,
                    textDirection: TextDirection.ltr,
                    child: Text(
                      author,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
