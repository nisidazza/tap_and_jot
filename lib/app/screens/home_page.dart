import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiggle_and_jot/app/data/backup_data.dart';
import 'package:jiggle_and_jot/app/models/api_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool shouldDisplay = false;
  late final Future myFuture;

  @override
  void initState() {
    super.initState();
    myFuture = fetchQuotes();
  }

  Future<List<Quotes>> fetchQuotes() async {
    var client = http.Client();
    var uri = Uri.parse("https://type.fit/api/quotes");
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((res) => Quotes.fromJson(res)).toList();
    } else {
      throw Exception("Failed to load answer");
    }
  }

  void showQuoteOnTap() {
    setState(() {
      shouldDisplay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showQuoteOnTap,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Your reading'),
          ),
          body: FutureBuilder(
              future: myFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  final backupQuote =
                      backupQuotes[Random().nextInt(backupQuotes.length)].text;
                  return loadQuote(backupQuote);
                } else if (snapshot.hasData) {
                  final quote = snapshot
                      .data![Random().nextInt(snapshot.data!.length)].text;
                  return loadQuote(quote);
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              })),
    );
  }

  SafeArea loadQuote(String quote) {
    return SafeArea(
        child: Center(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(shouldDisplay ? quote : ""))));
  }
}
