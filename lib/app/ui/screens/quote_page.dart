import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tap_and_jot/app/data/backup_data.dart';
import 'package:tap_and_jot/app/models/api_model.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  bool shouldDisplay = false;
  bool isOpaque = false;
  bool isBGImgOpaque = false;
  String bookImg = 'assets/quote_BG.jpg';
  late final Future myFuture;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    myFuture = fetchQuotes();
    timer = Timer(const Duration(seconds: 6), () {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
      shouldDisplay = !shouldDisplay;
      isOpaque = !isOpaque;
      isBGImgOpaque = !isBGImgOpaque;
    });
  }

  getRandomQuote(List<Quotes> data) {
    return data[Random().nextInt(data.length)];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showQuoteOnTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: isBGImgOpaque ? 0.4 : 1.0,
                image: AssetImage(bookImg),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: myFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return loadQuote(backupQuotes);
                    } else if (snapshot.hasData) {
                      return loadQuote(snapshot.data!);
                    } else {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 80),
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.all(0.5)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Back",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 20))),
              ),
            )
          ],
        ),
      ),
    );
  }

  SafeArea loadQuote(List<Quotes> quotes) {
    Quotes quote = getRandomQuote(quotes);
    String text = quote.text;
    String authorName = quote.author.split(",").first;
    String author = authorName == "type.fit" ? "" : authorName;
    return SafeArea(
        child: DefaultTextStyle(
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: AnimatedOpacity(
            opacity: isOpaque ? 1.0 : 0.0,
            duration: const Duration(seconds: 3),
            onEnd: () {
              timer = Timer(const Duration(seconds: 7), () {
                setState(() {
                  shouldDisplay = false;
                  isOpaque = false;
                  isBGImgOpaque = false;
                });
              });
            },
            child: shouldDisplay
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: GoogleFonts.lobster().fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 40,
                          )),
                      const SizedBox(height: 10),
                      Text(author),
                    ],
                  )
                : const Scaffold(
                    backgroundColor: Colors.transparent,
                  )),
      ),
    ));
  }
}
