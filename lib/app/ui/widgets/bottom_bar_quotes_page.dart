import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class BottomBarQuotesPage extends StatelessWidget {
  const BottomBarQuotesPage(
      {super.key,
      required this.isIconVisible,
      required this.screenshotController});

  final bool isIconVisible;
  final ScreenshotController screenshotController;

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
                    !isIconVisible ? captureAndSaveImage(context) : null;
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
        context: context,
        builder: (context) => Scaffold(
            appBar: AppBar(title: const Text("Captured widget screenshot")),
            body: Center(
                child: Image.memory(
              capturedImage,
              semanticLabel: "Quote screenshot",
            ))));
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
