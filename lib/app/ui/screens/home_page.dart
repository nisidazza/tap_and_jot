import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tap_and_jot/app/ui/screens/quotes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String morningImg = 'assets/morning.jpg';
  String afternoonImg = 'assets/afternoon.jpg';
  String eveningImg = 'assets/evening.jpg';
  String nightImg = 'assets/night.jpg';

  late String image;
  late String message;

  @override
  void initState() {
    super.initState();
  }

  String getImage() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      image = morningImg;
    } else if (hour >= 12 && hour < 17) {
      image = afternoonImg;
    } else if (hour >= 17 && hour < 21) {
      image = eveningImg;
    } else {
      image = nightImg;
    }
    return image;
  }

  String getMessage() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      message = "Happy Morning to you!";
    } else if (hour >= 12 && hour < 17) {
      message = "How’s your day?";
    } else if (hour >= 17 && hour < 21) {
      message = "Relax and unwind tonight!";
    } else {
      message = 'Good Vibes, Good Night!';
    }
    return message;
  }

  void goToQuote() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const QuotesPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Home Screen',
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: goToQuote,
        child: Semantics(
          container: true,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.95,
                    image: AssetImage(getImage()),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 60, left: 10, right: 10),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Semantics(
                            liveRegion: true,
                            label: getMessage(),
                            textDirection: TextDirection.ltr,
                            excludeSemantics: true,
                            child: HomeText(
                              text: getMessage(),
                              fontSize: 40,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Container(
                        alignment: Alignment.center,
                        child: Semantics(
                          excludeSemantics: true,
                          child: const HomeText(
                            text: "Tap & Jot!",
                            fontSize: 75,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Semantics(
                            button: true,
                            label: "Go to quote",
                            textDirection: TextDirection.ltr,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(300, 80),
                                    backgroundColor: Colors.transparent,
                                    padding: const EdgeInsets.all(0.5)),
                                onPressed: () {
                                  goToQuote();
                                },
                                child: const Text("Go to quote",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 20)),
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeText extends StatelessWidget {
  const HomeText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight});

  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: GoogleFonts.indieFlower().fontFamily,
          fontWeight: fontWeight,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          fontSize: fontSize,
          shadows: const [
            Shadow(
                color: Colors.black, blurRadius: 2.0, offset: Offset(2.0, 2.0))
          ],
        ));
  }
}
