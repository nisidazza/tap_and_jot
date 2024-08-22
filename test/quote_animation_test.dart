import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/providers/quotes_provider.dart';
import 'package:tap_and_jot/app/ui/widgets/quote_animation.dart';

import 'mock_provider.dart';

void main() {
  late MockQuotesProvider mockProvider;
  late Quote sampleQuote;

  setUp(() {
    mockProvider = MockQuotesProvider();
    sampleQuote = Quote(quote: "This is a test quote", author: "Test author");

    when(mockProvider.isQuoteVisible).thenReturn(true);
    when(mockProvider.isOpaque).thenReturn(true);
    when(mockProvider.isHandIconVisible).thenReturn(false);
    when(mockProvider.isLoading).thenReturn(false);
    when(mockProvider.errorMessage).thenReturn('');
    when(mockProvider.quotes).thenReturn([sampleQuote]);
  });

  Widget buildQuoteAnimationTestWidget() {
    return ChangeNotifierProvider<QuotesProvider>.value(
        value: mockProvider,
        child: MaterialApp(
            home: Scaffold(body: QuoteAnimation(quotes: [sampleQuote]))));
  }

  testWidgets("Displays quote when isQuoteVisible and isOpaque are true",
      (WidgetTester widgetTester) async {
    mockProvider = MockQuotesProvider();

    await widgetTester.pumpWidget(buildQuoteAnimationTestWidget());

    final findQuoteText = find.textContaining('This is a test quote');
    final findQuoteAuthor = find.textContaining('Test author');

    expect(findQuoteText, findsOneWidget);
    expect(findQuoteAuthor, findsOneWidget);
  });

  testWidgets("Hides quote when isQuoteVisible is false",
      (WidgetTester widgetTester) async {
    when(mockProvider.isQuoteVisible).thenReturn(false);

    await widgetTester.pumpWidget(buildQuoteAnimationTestWidget());

    final findQuoteText = find.textContaining('This is a test quote');
    final findQuoteAuthor = find.textContaining('Test author');

    expect(findQuoteText, findsNothing);
    expect(findQuoteAuthor, findsNothing);
  });
}
