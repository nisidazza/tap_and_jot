import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tap_and_jot/app/data/backup_data.dart';
import 'package:tap_and_jot/app/models/api_model.dart';
import 'package:tap_and_jot/app/ui/widgets/animated_hand_touch.dart';
import 'package:tap_and_jot/app/ui/widgets/single_quote.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  bool shouldDisplay = false;
  bool isOpaque = false;
  bool isBGImgOpaque = false;
  bool isIconVisible = true;
  String bookImg = 'assets/quote_BG.jpg';
  late Future<List<Quote>> futureQuotes;
  Timer? iconVisibilityTimer;
  bool _disposed = false;
  late Uint8List screenshotFile;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    futureQuotes = fetchQuotes(http.Client());
    iconVisibilityTimer = Timer(const Duration(seconds: 3), () {
      if (!_disposed) {
        setState(() {
          isIconVisible = false;
        });
      }
    });
    // debugPrint("QuotePage initState completed.");
  }

  @override
  void dispose() {
    _disposed = true;
    iconVisibilityTimer?.cancel();
    // debugPrint("QuotePage disposed and timer cancelled.");
    super.dispose();
  }

  void showQuoteOnTap() {
    if (!_disposed) {
      setState(() {
        shouldDisplay = !shouldDisplay;
        isOpaque = !isOpaque;
        isBGImgOpaque = !isBGImgOpaque;
      });
    }
  }

  getRandomQuote(List<Quote> data) {
    return data[Random().nextInt(data.length)];
  }

  Future<dynamic> showCapturedImage(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
        context: context,
        builder: (context) => Scaffold(
            appBar: AppBar(title: const Text("Captured widget screenshot")),
            body: Center(
                child: Image.memory(
              capturedImage,
              semanticLabel: "Quote screenshot",
            ))));
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: IgnorePointer(
        ignoring: isIconVisible,
        child: Semantics(
          label: 'Quote Screen',
          textDirection: TextDirection.ltr,
          liveRegion: true,
          button: true,
          child: GestureDetector(
            onTap: showQuoteOnTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(bookImg), fit: BoxFit.cover)),
              child: Semantics(
                expanded: true,
                liveRegion: true,
                child: Column(
                  children: [
                    Expanded(
                        child: isIconVisible
                            ? Visibility(
                                visible: isIconVisible,
                                child: const AnimatedHandTouch(),
                              )
                            : Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                        sigmaX: 10.0,
                                        sigmaY: 10.0,
                                        tileMode: TileMode.decal),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 5),
                                      decoration: shouldDisplay
                                          ? BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              border: Border.all(
                                                  color: Colors.transparent,
                                                  width: 3.0),
                                            )
                                          : null,
                                    ),
                                  ),
                                  FutureBuilder<List<Quote>>(
                                      future: futureQuotes,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Semantics(
                                            label: 'Loading',
                                            textDirection: TextDirection.ltr,
                                            excludeSemantics: true,
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return SingleQuote(
                                            quote: getRandomQuote(backupQuotes),
                                            shouldDisplay: shouldDisplay,
                                            isOpaque: isOpaque,
                                          );
                                        } else if (snapshot.hasData) {
                                          return SingleQuote(
                                            quote:
                                                getRandomQuote(snapshot.data!),
                                            shouldDisplay: shouldDisplay,
                                            isOpaque: isOpaque,
                                          );
                                        } else {
                                          return const Center(
                                            child: Text(
                                              'No data available',
                                              textDirection: TextDirection.ltr,
                                            ),
                                          );
                                        }
                                      }),
                                ],
                              )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Semantics(
                                  button: true,
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
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
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontSize: 20))),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Semantics(
                                    button: true,
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: IconButton(
                                        icon: const Icon(Icons.photo_camera,
                                            color: Colors.white, size: 30),
                                        style: IconButton.styleFrom(
                                            fixedSize: const Size(300, 80),
                                            backgroundColor: Colors.transparent,
                                            padding: const EdgeInsets.all(0.5)),
                                        onPressed: () {
                                          !isIconVisible
                                              ? captureAndSaveImage(context)
                                              : null;
                                        },
                                      ),
                                    )),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> captureAndSaveImage(BuildContext context) {
    return screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        showCapturedImage(context, image);
        await ImageGallerySaver.saveImage(image);
      }
    }).catchError((error) {
      print(error);
    });
  }
}
