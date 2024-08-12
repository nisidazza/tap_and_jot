import 'dart:async';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tap_and_jot/app/ui/screens/about_page.dart';

class BottomBarQuotesPage extends StatelessWidget {
  const BottomBarQuotesPage(
      {super.key,
      required this.isHandIconVisible,
      required this.screenshotController});

  final bool isHandIconVisible;
  final ScreenshotController screenshotController;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(
              icon: Icons.home,
              semanticLabel: 'home',
              onPressed: () {
                Navigator.pop(context);
              }),
          _buildIconButton(
              icon: Icons.photo_camera,
              semanticLabel: 'screenshot',
              onPressed: () {
                !isHandIconVisible
                    ? screenshotController
                        .capture()
                        .then((Uint8List? image) async {
                        showScreenshot(context, image!);
                      }).catchError((error) {
                        print(error);
                        _showErrorSnackBar(
                            context, 'Failed to capture screenshot');
                      })
                    : null;
              }),
          _buildIconButton(
            icon: Icons.description,
            semanticLabel: 'description',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          )
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String semanticLabel,
    required VoidCallback? onPressed,
  }) {
    return Semantics(
      button: true,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
              size: 30,
              semanticLabel: semanticLabel,
            ),
            onPressed: onPressed),
      ),
    );
  }

  Future<dynamic> showScreenshot(BuildContext context, Uint8List image) {
    return showDialog(
        useSafeArea: false,
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDialogIconButton(
                          icon: Icons.close,
                          color: Colors.red,
                          semanticLabel: 'close',
                          onPressed: () => Navigator.of(context).pop(true)),
                      _buildDialogIconButton(
                          icon: Icons.save_alt,
                          color: Colors.green,
                          semanticLabel: 'save',
                          onPressed: () => {
                                ImageGallerySaver.saveImage(image),
                                Future.delayed(const Duration(seconds: 1),
                                    () => Navigator.of(context).pop(true))
                              }),
                      _buildDialogIconButton(
                        icon: Icons.share,
                        color: Colors.blueGrey,
                        semanticLabel: 'share',
                        onPressed: () => {
                          Share.shareXFiles(
                              [XFile.fromData(image, mimeType: 'png')])
                        },
                      )
                    ],
                  ),
                  Center(
                      child: Image.memory(
                    image,
                    semanticLabel: "Quote screenshot",
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 18.0),
                    child: Semantics(
                      label: "save or share screenshot",
                      excludeSemantics: true,
                      textDirection: TextDirection.ltr,
                      child: const AutoSizeText(
                          "Save or Share your favorite quote",
                          maxLines: 1,
                          minFontSize: 15,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                ])));
  }

  Widget _buildDialogIconButton({
    required IconData icon,
    required Color color,
    required String semanticLabel,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
        semanticLabel: semanticLabel,
        size: 30,
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
