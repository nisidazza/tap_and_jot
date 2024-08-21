import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/providers/quotes_provider.dart';

class QuoteAnimation extends StatelessWidget {
  const QuoteAnimation({super.key, required this.quotes});

  final List<Quote> quotes;

  getRandomQuote(List<Quote> data) {
    return data[Random().nextInt(data.length)];
  }

  capitalizeText(String text) {
    List<String> sentences = text.split(".");

    List<String> trimmedSentences =
        sentences.map((sentence) => sentence.trim()).toList();

    List<String> processedSentences = trimmedSentences.map((sentence) {
      String lowerCaseSentence = sentence.toLowerCase();
      String capitalizedSentence =
          intl.toBeginningOfSentenceCase(lowerCaseSentence);
      // Correct the case for the pronoun "I"
      return capitalizedSentence.replaceAll(RegExp(r'\bi\b'), 'I');
    }).toList();

    return processedSentences.join(". ");
  }

  @override
  Widget build(BuildContext context) {
    Quote quoteObj = getRandomQuote(quotes);
    String capitalizedText = capitalizeText(quoteObj.quote);

    String author = quoteObj.author;
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
                    visible: provider.isQuoteVisible,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Semantics(
                            label: capitalizedText,
                            excludeSemantics: true,
                            textDirection: TextDirection.ltr,
                            child: AutoSizeText(capitalizedText,
                                maxLines: 6,
                                minFontSize: 13,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily:
                                      GoogleFonts.badScript().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 45,
                                )),
                          ),
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
