import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:tap_and_jot/app/models/api_model.dart';

const endpoint = "https://dummyjson.com/quotes";

Future<List<Quote>> fetchQuotes(http.Client client) async {
  late List<Quote> quotes;
  try {
    var uri = Uri.parse(endpoint);
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      quotes = parseQuote(response.body);
    } else {
      throw Exception("Failed to load answer");
    }
  } catch (e) {
    print('Error occured $e');
    throw Exception('Error occured $e');
  }
  return quotes;
}

List<Quote> parseQuote(String responseBody) {
  final Map<String, dynamic> parsedJson = jsonDecode(responseBody);

  if (parsedJson.containsKey('quotes')) {
    if (parsedJson['quotes'] is List<dynamic>) {
      var result = (parsedJson['quotes'] as List<dynamic>)
          .map<Quote>((json) => Quote.fromJson(json as Map<String, dynamic>))
          .toList(); // map() returns an Iterable so we convert it to a List
      return result;
    } else {
      throw Exception("'quotes' is not a list");
    }
  } else {
    throw Exception("Ket 'quotes' not found in the JSON response");
  }
}
