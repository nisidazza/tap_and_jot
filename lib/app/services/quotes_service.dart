import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tap_and_jot/app/models/api_model.dart';

Future<List<Quote>> fetchQuotes(http.Client client) async {
  var uri = Uri.parse("https://type.fit/api/quotes");
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    final quotes = parseQuote(response.body);
    return quotes;
  } else {
    throw Exception("Failed to load answer");
  }
}

List<Quote> parseQuote(String responseBody) {
  final parsedJson = jsonDecode(responseBody) as List;
  // print('${parsedJson.runtimeType} : $parsedJson');
  return parsedJson
      .map<Quote>((json) => Quote.fromJson(json as Map<String, dynamic>))
      .toList(); // map() returns an Iterable so we convert it to a List
}
