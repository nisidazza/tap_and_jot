import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tap_and_jot/app/models/api_model.dart';

import 'fetch_quotes_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchQuotes', () {
    test('returns a list of Quotes if the http call complete successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse('https://type.fit/api/quotes'))).thenAnswer(
          (_) async => http.Response(
              '[{"text": "mock quote", "author": "mock author"}]', 200));

      expect(await fetchQuotes(client), isA<List<Quote>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client.get(Uri.parse('https://type.fit/api/quotes')))
          .thenAnswer((_) async => http.Response('Not found', 404));

      expect(fetchQuotes(client), throwsException);
    });
  });
}
