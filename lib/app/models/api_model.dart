import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// A function that converts a response body into a List<Quote>.
List<Quote> parseQuote(String responseBody) {
  return (jsonDecode(responseBody) as List)
      .map<Quote>((json) => Quote.fromJson(json))
      .toList();
}

Future<List<Quote>> fetchQuotes(http.Client client) async {
  var uri = Uri.parse("https://type.fit/api/quotes");
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    final quotes = parseQuote(response.body);
    if (kDebugMode) {
      print(quotes.first);
    }
    return quotes;
  } else {
    throw Exception("Failed to load answer");
  }
}

class Quote {
  final String text;
  final String author;

  Quote({
    required this.text,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
        text: json['text'] as String, author: json['author'] as String);
  }
}
