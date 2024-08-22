// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/providers/quotes_provider.dart';
import 'package:tap_and_jot/app/ui/screens/home_page.dart';
import 'package:tap_and_jot/app/ui/screens/quotes_page.dart';

import 'fetch_quotes_test.mocks.dart';
import 'mock_provider.dart';

void main() {
  late MockQuotesProvider mockProvider;
  late Quote sampleQuote;
  late MockClient client;
  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });

  setUp(() {
    mockProvider = MockQuotesProvider();
    sampleQuote = Quote(quote: "This is a test quote", author: "Test author");
    client = MockClient();

    when(mockProvider.isQuoteVisible).thenReturn(true);
    when(mockProvider.isOpaque).thenReturn(true);
    when(mockProvider.isHandIconVisible).thenReturn(false);
    when(mockProvider.isLoading).thenReturn(false);
    when(mockProvider.errorMessage).thenReturn('');
    when(mockProvider.quotes).thenReturn([sampleQuote]);
    when(mockProvider.fetchData()).thenAnswer((_) async {
      // Simulate the fetchQuotes method returning successfully
      when(client.get(Uri.parse('https://dummyjson.com/quotes'))).thenAnswer(
        (_) async => http.Response(
          '{"quotes": [{"quote": "This is a test quote", "author": "Test author"}]}',
          200,
        ),
      );
    });
    when(mockProvider.fetchData()).thenAnswer((_) async {
      // Simulate the sequence of actions in fetchData
      when(mockProvider.isLoading).thenReturn(true);
      when(mockProvider.errorMessage).thenReturn('');

      // Simulate a delay to mimic network call
      await Future.delayed(Duration.zero);

      when(mockProvider.isLoading).thenReturn(false);
      when(mockProvider.quotes).thenReturn([sampleQuote]);
    });
  });
  testWidgets('Home Screen meets a11y criteria', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(ChangeNotifierProvider<QuotesProvider>.value(
        value: mockProvider,
        child: const MaterialApp(home: Scaffold(body: HomePage()))));

    await tester.pumpAndSettle();

    // Checks that tappable nodes have a minimum size of 48 by 48 pixels
    // for Android.
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

    // Checks that tappable nodes have a minimum size of 44 by 44 pixels
    // for iOS.
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

    // Checks that touch targets with a tap or long press action are labeled.
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    // Checks whether semantic nodes meet the minimum text contrast levels.
    // The recommended text contrast is 3:1 for larger text
    // (18 point and above regular).
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });

  testWidgets('Quote Screen meets a11y criteria', (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();

    await tester.pumpWidget(ChangeNotifierProvider<QuotesProvider>.value(
        value: mockProvider,
        child: const MaterialApp(home: Scaffold(body: QuotesPage()))));

    // Checks that tappable nodes have a minimum size of 48 by 48 pixels
    // for Android.
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

    // Checks that tappable nodes have a minimum size of 44 by 44 pixels
    // for iOS.
    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

    // // Checks that touch targets with a tap or long press action are labeled.
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    // // Checks whether semantic nodes meet the minimum text contrast levels.
    // // The recommended text contrast is 3:1 for larger text
    // // (18 point and above regular).
    await expectLater(tester, meetsGuideline(textContrastGuideline));

    await tester.pump(const Duration(seconds: 3));

    handle.dispose();
  });
}
