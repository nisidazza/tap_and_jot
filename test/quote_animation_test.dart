import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/ui/widgets/quote_animation.dart';

final Quote mockQuote = Quote(text: "first quote", author: "first author");

void main() {
  group("Single Quote Widget", () {
    testWidgets("it should display a quote when shouldDisplay is true",
        (widgetTester) async {
      Widget quoteAnimation =
          QuoteAnimation(quote: mockQuote, shouldDisplay: true, isOpaque: true);

      await widgetTester.pumpWidget(quoteAnimation);

      final textFinder = find.text("first quote");
      final authorFinder = find.text("first author");

      expect(textFinder, findsOne);
      expect(authorFinder, findsOne);
    });

    testWidgets("it should not display a quote when shouldDisplay is false",
        (widgetTester) async {
      Widget quoteAnimation = QuoteAnimation(
          quote: mockQuote, shouldDisplay: false, isOpaque: true);

      await widgetTester.pumpWidget(quoteAnimation);

      final textFinder = find.text("first quote");
      final authorFinder = find.text("first author");

      expect(textFinder, findsNothing);
      expect(authorFinder, findsNothing);
    });
  });
}
