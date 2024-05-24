import 'dart:convert';

import 'package:http/http.dart' as http;

List<Quote> parseQuote(String responseBody) {
  final parsedJson = jsonDecode(responseBody) as List;
  // print('${parsedJson.runtimeType} : $parsedJson');
  return parsedJson
      .map<Quote>((json) => Quote.fromJson(json as Map<String, dynamic>))
      .toList(); // map() returns an Iterable so we convert it to a List
}

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

class Quote {
  final String text;
  final String author;

  Quote({
    required this.text,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'text': String text,
          'author': String author,
        }) {
      return Quote(text: text, author: author);
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }
}
