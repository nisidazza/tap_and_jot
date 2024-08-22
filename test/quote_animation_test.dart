import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/providers/quotes_provider.dart';
import 'package:tap_and_jot/app/ui/widgets/quote_animation.dart';

class MockQuotesProvider extends Mock implements QuotesProvider {
  @override
  bool get isQuoteVisible =>
      super.noSuchMethod(Invocation.getter(#isQuoteVisible),
          returnValue: true, returnValueForMissingStub: true);

  @override
  bool get isOpaque => super.noSuchMethod(Invocation.getter(#isOpaque),
      returnValue: true, returnValueForMissingStub: true);

  @override
  bool get isHandIconVisible =>
      super.noSuchMethod(Invocation.getter(#isHandIconVisible),
          returnValue: true, returnValueForMissingStub: true);

  @override
  bool get isLoading => super.noSuchMethod(Invocation.getter(#isLoading),
      returnValue: false, returnValueForMissingStub: false);

  @override
  String get errorMessage =>
      super.noSuchMethod(Invocation.getter(#errorMessage),
          returnValue: '', returnValueForMissingStub: '');

  @override
  List<Quote> get quotes =>
      super.noSuchMethod(Invocation.getter(#quotes), returnValue: [
        Quote(quote: 'Sample Quote', author: 'Author')
      ], returnValueForMissingStub: [
        Quote(quote: 'Sample Quote', author: 'Author')
      ]);
}

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
