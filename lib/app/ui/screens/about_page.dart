import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final Uri googlePlayStoreUrl = Uri.parse(
      "https://play.google.com/store/apps/details?id=com.nisiazza.tap_and_jot");

  final Uri privacyPolicyUrl = Uri.parse(
      "https://github.com/nisidazza/tap-and-jot-privacy-policy/blob/main/privacy-policy.md");

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.80,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Semantics(
                        button: true,
                        child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.grey,
                                size: 30,
                                semanticLabel: 'back',
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ))),
                  ],
                ),
              ),
              Expanded(
                child: AutoSizeText(
                    "Tap & Jot is an inspiration-packed app designed to provide you with uplifting quotes at the tap of a screen. It's a simple, straightforward way to get a daily dose of motivation. Whether you need a morning boost, midday motivation, or evening reflections, Tap & Jot has got you covered. Run into the same quote multiple times? It could be a sign! Let these moments of serendipity inspire you even more.",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: GoogleFonts.indieFlower().fontFamily,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    )),
              ),
              const SizedBox(height: 2),
              ButtonLink(
                launch: launchGooglePlayStoreUrl,
                text:
                    "Provide feedback on what you love and what can be improved.",
              ),
              const SizedBox(height: 4),
              ButtonLink(launch: launchPrivacyPolicyUrl, text: "Privacy Policy")
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> launchGooglePlayStoreUrl() async {
    if (!await launchUrl(googlePlayStoreUrl)) {
      throw Exception('Could not launch $googlePlayStoreUrl');
    }
  }

  Future<void> launchPrivacyPolicyUrl() async {
    if (!await launchUrl(privacyPolicyUrl)) {
      throw Exception('Could not launch $privacyPolicyUrl');
    }
  }
}

class ButtonLink extends StatelessWidget {
  const ButtonLink({super.key, required this.launch, required this.text});

  final void Function() launch;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: launch,
      style: const ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStatePropertyAll(Colors.transparent)),
      child: AutoSizeText(text,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: TextStyle(
            decorationColor: Colors.lightBlue,
            color: Colors.lightBlue,
            fontFamily: GoogleFonts.indieFlower().fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 23,
          )),
    );
  }
}
