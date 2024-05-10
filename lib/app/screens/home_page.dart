import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiggle_and_jot/app/models/api_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Quotes>? quotes = [];
  var randomQuote = '';
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    loadQuotes();
  }

  Future<void> loadQuotes() async {
    var client = http.Client();
    var uri = Uri.parse("https://type.fit/api/quotes");
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        isLoaded = true;
        quotes = (jsonData.map((res) => Quotes.fromJson(res)).toList());
        randomQuote = quotes!.isNotEmpty
            ? quotes![Random().nextInt(quotes!.length)].text
            : "";
      });
    } else {
      throw Exception("Failed to load answer");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your reading'),
        ),
        body: isLoaded && quotes != null
            ? SafeArea(child: Center(child: Text(randomQuote)))
            : const Center(child: CircularProgressIndicator()));
  }
}
