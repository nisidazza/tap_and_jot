import 'package:mockito/mockito.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/providers/quotes_provider.dart';

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
