import 'dart:convert';

import 'package:http/http.dart' as http;

List<Quotes> parseQuotes(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Quotes>((json) => Quotes.fromJson(json)).toList();
}

Future<List<Quotes>> fetchQuotes(http.Client client) async {
  var uri = Uri.parse("https://type.fit/api/quotes");
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    return parseQuotes(response.body);
  } else {
    throw Exception("Failed to load answer");
  }
}

class Quotes {
  final String text;
  final String author;

  Quotes({
    required this.text,
    required this.author,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'text': String text,
        'author': String author,
      } =>
        Quotes(
          text: text,
          author: author,
        ),
      _ => throw const FormatException('Failed to load quotes')
    };
  }
}
