import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/providers/quotes_provider.dart';
import 'package:tap_and_jot/app/ui/widgets/quote_animation.dart';

final List<Quote> mockQuote = [
  Quote(text: "first quote", author: "first author"),
  Quote(text: "second quote", author: "second author"),
  Quote(text: "third quote", author: "third author")
];

void main() {
  group("Single Quote Widget", () {
    testWidgets("it should display a quote when shouldDisplay is true",
        (widgetTester) async {
      Widget quoteAnimation = QuoteAnimation(quotes: mockQuote);

      await widgetTester.pumpWidget(MultiProvider(providers: [
        Provider<QuotesProvider>(
          create: (_) => QuotesProvider(),
        )
      ], child: quoteAnimation));

      expect(find.byType(Text), findsExactly(2));
    });

    testWidgets("it should not display a quote when shouldDisplay is false",
        (widgetTester) async {
      Widget quoteAnimation = QuoteAnimation(quotes: mockQuote);

      await widgetTester.pumpWidget(MultiProvider(providers: [
        Provider<QuotesProvider>(
          create: (_) => QuotesProvider(),
        )
      ], child: quoteAnimation));

      expect(find.byType(Text), findsNothing);
    });
  });
}
