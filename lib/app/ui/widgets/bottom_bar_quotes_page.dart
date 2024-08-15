import 'dart:async';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tap_and_jot/app/ui/screens/about_page.dart';

class BottomBarQuotesPage extends StatefulWidget {
  const BottomBarQuotesPage({super.key, required this.screenshotController});

  final ScreenshotController screenshotController;

  @override
  State<BottomBarQuotesPage> createState() => _BottomBarQuotesPageState();
}

class _BottomBarQuotesPageState extends State<BottomBarQuotesPage> {
  late Uint8List? capturedImage;

  @override
  void initState() {
    super.initState();
    capturedImage = null;
  }

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
              onPressed: () async {
                await showScreenshot(context);
              }),
          // onPressed: () {
          //   widget.screenshotController
          //       .capture()
          //       .then((Uint8List? image) async {
          //     if (image != null) {
          //       showScreenshot(context, image);
          //     }
          //   }).catchError((error) {
          //     print(error);
          //     _showErrorSnackBar(context, 'Failed to capture screenshot');
          //   });
          // }),
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

  Future<void> showScreenshot(BuildContext context) async {
    await showDialog(
        useSafeArea: true,
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: FutureBuilder<Uint8List?>(
                  future: onImageCapture(context),
                  builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                    return snapshot.hasData
                        ? _buildScreenshotDialog(context, snapshot.data)
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  }));
        });
  }

  Column _buildScreenshotDialog(BuildContext context, Uint8List? image) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDialogIconButton(
                    icon: Icons.close,
                    color: Colors.red,
                    semanticLabel: 'close',
                    onPressed: () => {
                          Navigator.of(context).pop(true),
                        }),
                _buildDialogIconButton(
                    icon: Icons.save_alt,
                    color: Colors.green,
                    semanticLabel: 'save',
                    onPressed: () => {
                          ImageGallerySaver.saveImage(capturedImage!),
                          Future.delayed(const Duration(seconds: 1),
                              () => Navigator.of(context).pop(true))
                        }),
                _buildDialogIconButton(
                  icon: Icons.share,
                  color: Colors.blueGrey,
                  semanticLabel: 'share',
                  onPressed: () => {
                    Share.shareXFiles(
                        [XFile.fromData(capturedImage!, mimeType: 'png')])
                  },
                )
              ],
            ),
          ),
          Expanded(
              flex: 7,
              child: Center(
                child: Image.memory(
                  frameBuilder: (BuildContext context, Widget child, int? frame,
                      bool wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) {
                      return child;
                    }
                    return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: child);
                  },
                  image!,
                  semanticLabel: "Quote screenshot",
                ),
              )),
          Expanded(
            flex: 1,
            child: Center(
              child: Semantics(
                label: "save or share screenshot",
                excludeSemantics: true,
                textDirection: TextDirection.ltr,
                child: const AutoSizeText("Save or Share your favorite quote",
                    maxLines: 1,
                    minFontSize: 15,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
          ),
        ]);
  }

  Future<Uint8List?> onImageCapture(BuildContext context) async {
    return await widget.screenshotController
        .capture()
        .then((Uint8List? image) async {
      setState(() {
        capturedImage = image;
      });
      return image;
    }).catchError((error) async {
      print(error);
      _showErrorSnackBar(context, 'Failed to capture screenshot');
      return null;
    });
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
