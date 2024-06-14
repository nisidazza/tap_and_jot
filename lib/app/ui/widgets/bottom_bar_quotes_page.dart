import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class BottomBarQuotesPage extends StatefulWidget {
  const BottomBarQuotesPage(
      {super.key,
      required this.isIconVisible,
      required this.screenshotController});

  final bool isIconVisible;
  final ScreenshotController screenshotController;

  @override
  State<BottomBarQuotesPage> createState() => _BottomBarQuotesPageState();
}

class _BottomBarQuotesPageState extends State<BottomBarQuotesPage> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Semantics(
            button: true,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                  semanticLabel: 'home',
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Semantics(
              button: true,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: IconButton(
                  icon: const Icon(
                    Icons.photo_camera,
                    color: Colors.white,
                    size: 30,
                    semanticLabel: 'screenshot',
                  ),
                  onPressed: () {
                    !widget.isIconVisible ? captureImage(context) : null;
                  },
                ),
              )),
        ],
      ),
    );
  }

  Future<dynamic> showCapturedImage(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  icon: const Icon(Icons.delete,
                      color: Colors.red, semanticLabel: 'delete', size: 30)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.save_alt,
                      color: Colors.green, semanticLabel: 'save', size: 30),
                  onPressed: () => {
                    ImageGallerySaver.saveImage(capturedImage),
                    Future.delayed(const Duration(seconds: 1),
                        () => Navigator.of(context).pop(true))
                  },
                ),
              ],
            ),
            body: Center(
                child: Image.memory(
              capturedImage,
              semanticLabel: "Quote screenshot",
            ))));
  }

  Future<Null> captureImage(BuildContext context) {
    return widget.screenshotController.capture().then((Uint8List? image) {
      if (image != null) {
        showCapturedImage(context, image);
      }
    }).catchError((error) {
      print(error);
    });
  }
}
