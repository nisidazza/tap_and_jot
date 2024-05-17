import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiggle_and_jot/app/data/backup_data.dart';
import 'package:jiggle_and_jot/app/models/api_model.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
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
    return SafeArea(
      child: GestureDetector(
        onTap: showQuoteOnTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.lightBlueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder(
                  future: myFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      final backupQuote =
                          backupQuotes[Random().nextInt(backupQuotes.length)];
                      return loadQuote(backupQuote);
                    } else if (snapshot.hasData) {
                      final quote = snapshot
                          .data![Random().nextInt(snapshot.data!.length)];
                      return loadQuote(quote);
                    } else {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                  }),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 80),
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.all(0.5)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Back to Home Page",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 20))),
              )
            ],
          ),
        ),
      ),
    );
  }

  SafeArea loadQuote(Quotes quote) {
    String text = quote.text;
    String authorName = quote.author.split(",").first;
    String author = authorName == "type.fit" ? "" : authorName;
    return SafeArea(
        child: Center(
            child: SizedBox(
      child: DefaultTextStyle(
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(shouldDisplay ? text : ""),
            const SizedBox(height: 10),
            Text(shouldDisplay ? author : ""),
          ],
        ),
      ),
    )));
  }
}
