import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/providers/quotes_provider.dart';

class QuoteAnimation extends StatelessWidget {
  const QuoteAnimation({super.key, required this.quotes});

  final List<Quote> quotes;

  getRandomQuote(List<Quote> data) {
    return data[Random().nextInt(data.length)];
  }

  @override
  Widget build(BuildContext context) {
    Quote quoteObj = getRandomQuote(quotes);
    String? text = quoteObj.quote;
    String? authorName = quoteObj.author.split(",").first;
    String author = authorName == "type.fit" ? "" : authorName;
    return DefaultTextStyle(
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.85,
          alignment: Alignment.center,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child:
                  Consumer<QuotesProvider>(builder: (context, provider, child) {
                return AnimatedOpacity(
                  opacity: provider.isOpaque ? 1.0 : 0.0,
                  duration: const Duration(seconds: 3),
                  child: Visibility(
                    visible: provider.shouldDisplay,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Semantics(
                          label: text,
                          excludeSemantics: true,
                          textDirection: TextDirection.ltr,
                          child: AutoSizeText(text,
                              maxLines: 3,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: GoogleFonts.badScript().fontFamily,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                                fontSize: 55,
                              )),
                        ),
                        const SizedBox(height: 10),
                        Semantics(
                          label: author,
                          excludeSemantics: true,
                          textDirection: TextDirection.ltr,
                          child: AutoSizeText(author,
                              maxLines: 1,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ));
  }
}
