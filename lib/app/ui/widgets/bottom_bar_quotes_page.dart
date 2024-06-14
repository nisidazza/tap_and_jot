import 'dart:async';
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
          const HomeIconButton(),
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
                      !isIconVisible ? captureImage(context) : null;
                    },
                  ))),
        ],
      ),
    );
  }

  Future<dynamic> captureImage(BuildContext context) {
    return screenshotController.capture().then((Uint8List? image) {
      if (image != null) {
        return showScreenshot(context, image);
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<dynamic> showScreenshot(BuildContext context, Uint8List image) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      icon: const Icon(Icons.delete,
                          color: Colors.red,
                          semanticLabel: 'delete',
                          size: 30)),
                  IconButton(
                    icon: const Icon(Icons.save_alt,
                        color: Colors.green, semanticLabel: 'save', size: 30),
                    onPressed: () => {
                      ImageGallerySaver.saveImage(image),
                      Future.delayed(const Duration(seconds: 1),
                          () => Navigator.of(context).pop(true))
                    },
                  ),
                ],
              ),
            ),
            Center(
                child: Image.memory(
              image,
              semanticLabel: "Quote screenshot",
            ))
          ])),
    );
  }
}

class HomeIconButton extends StatelessWidget {
  const HomeIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
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
    );
  }
}
