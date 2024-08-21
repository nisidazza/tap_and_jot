import 'dart:convert';

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
    print('Error occured $e.toString()');
    throw Exception('Error occured $e.toString()');
  }
  return quotes;
}

List<Quote> parseQuote(String responseBody) {
  final parsedJson = jsonDecode(responseBody)['quotes'];

  var result = parsedJson
      .map<Quote>((json) => Quote.fromJson(json as Map<String, dynamic>))
      .toList(); // map() returns an Iterable so we convert it to a List
  return result;
}
