import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:screenshot/screenshot.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/ui/widgets/bottom_bar_quotes_page.dart';
import 'package:tap_and_jot/app/ui/widgets/future_builder_quotes.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  bool shouldDisplay = false;
  bool isOpaque = false;

  String bookImg = 'assets/quote_BG.jpg';
  late Future<List<Quote>> futureQuotes;
  late Uint8List screenshotFile;
  bool isHandIconVisible = true;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    futureQuotes = fetchQuotes(http.Client());
  }

  void showQuoteOnTap() {
    setState(() {
      shouldDisplay = !shouldDisplay;
      isOpaque = !isOpaque;
      isHandIconVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Screenshot(
          controller: screenshotController,
          child: Semantics(
            label: 'Quote Screen',
            textDirection: TextDirection.ltr,
            liveRegion: true,
            button: true,
            child: GestureDetector(
              onTap: showQuoteOnTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bookImg), fit: BoxFit.cover)),
                child: Semantics(
                    expanded: true,
                    liveRegion: true,
                    child: FutureBuilderQuotes(
                        futureQuotes: futureQuotes,
                        shouldDisplay: shouldDisplay,
                        isOpaque: isOpaque,
                        showQuoteOnTap: showQuoteOnTap,
                        isHandIconVisible: isHandIconVisible)),
              ),
            ),
          ),
        ),
        bottomNavigationBar:
            BottomBarQuotesPage(screenshotController: screenshotController),
      ),
    );
  }
}
