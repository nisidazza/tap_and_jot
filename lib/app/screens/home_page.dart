import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiggle_and_jot/app/screens/quote_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String morningImg = 'assets/morning.jpg';
  String afternoonImg = 'assets/afternoon.jpg';
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
    } else if (hour < 17) {
      image = afternoonImg;
    } else {
      image = nightImg;
    }
    return image;
  }

  String getMessage() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      message = "Good Morning!";
    } else if (hour < 17) {
      message = "Good Afternoon!";
    } else {
      message = "Good Night!";
    }
    return message;
  }

  void goToQuote() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const QuotePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Your reading'),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(getImage()), fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(getMessage(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: GoogleFonts.allura().fontFamily,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontSize: 80,
                        shadows: const [
                          Shadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              offset: Offset(2.0, 2.0))
                        ],
                      )),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 80),
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.all(0.5)),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const QuotePage()));
                      goToQuote();
                    },
                    child: const Text("Tap & Jot",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 20))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
