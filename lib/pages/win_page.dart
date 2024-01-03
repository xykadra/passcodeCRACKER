import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:passcodecr/pages/easy_game_mode.dart';
import 'package:passcodecr/pages/easy_plus.dart';
import 'package:passcodecr/pages/extreme_game_mode.dart';
import 'package:passcodecr/pages/hard_game_mode.dart';
import 'package:passcodecr/pages/medium_game_mode.dart';

class WinPage extends StatelessWidget {
  final List<int> randomNumbers;
  final String nameOfPage;
  final List<Widget> tries;

  WinPage({
    required this.randomNumbers,
    required this.nameOfPage,
    required this.tries,
  });

  String nameOfBackPage = "";
  void checkBackName(String nameOfPage) {
    if (nameOfPage == "Easy") {
      nameOfBackPage = "Easy";
    }
    if (nameOfPage == "EasyPlus") {
      nameOfBackPage = "EasyPlus";
    }
    if (nameOfPage == "Medium") {
      nameOfBackPage = "Medium";
    }
    if (nameOfPage == "Hard") {
      nameOfBackPage = "Hard";
    }
    if (nameOfPage == "Extreme") {
      nameOfBackPage = "Extreme";
    }
  }

  initState() {
    checkBackName(nameOfPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nameOfBackPage,
              style: GoogleFonts.sourceCodePro(
                  fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: tries,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "YESS, YOUR NUMBERS WERE",
                        style: GoogleFonts.inter(fontSize: 20),
                      ),
                      Text(
                        randomNumbers
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', '')
                            .replaceAll(',', ""),
                        style: GoogleFonts.inter(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Lottie.asset(
              "lib/assets/win.json",
            ),

            GestureDetector(
              onTap: () {
                if (nameOfPage == "Easy") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EasyGameMode(),
                      ));
                }
                if (nameOfPage == "EasyPlus") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EasyPlusGameMode(),
                      ));
                }

                if (nameOfPage == "Medium") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MediumGameMode(),
                      ));
                }
                if (nameOfPage == "Hard") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HardGameMode(),
                      ));
                }
                if (nameOfPage == "Extreme") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExtremeGameMode(),
                      ));
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Play again",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.loop,
                          size: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       "Total wins today: SOON",
            //       style: GoogleFonts.sourceCodePro(fontWeight: FontWeight.bold),
            //     ),
            //     Text(
            //       "Best time: SOON",
            //       style: GoogleFonts.sourceCodePro(fontWeight: FontWeight.bold),
            //     )
            //   ],
            // )
          ],
        )),
      ),
    );
  }
}
