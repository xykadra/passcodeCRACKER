import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:passcodecr/pages/easy_game_mode.dart';
import 'package:passcodecr/pages/easy_plus.dart';
import 'package:passcodecr/pages/extreme_game_mode.dart';
import 'package:passcodecr/pages/hard_game_mode.dart';
import 'package:passcodecr/pages/medium_game_mode.dart';

import 'easy_game_mode.dart';

class GameOverPage extends StatefulWidget {
  final List<int> randomNumbers;
  final String nameOfPage;

  GameOverPage({required this.randomNumbers, required this.nameOfPage});

  @override
  State<GameOverPage> createState() => _GameOverPageState();
}

class _GameOverPageState extends State<GameOverPage> {
  String nameOfBackPage = "";

  void checkBackName(String nameOfPage) {
    if (widget.nameOfPage == "Easy") {
      nameOfBackPage = "Easy";
    }
    if (widget.nameOfPage == "EasyPlus") {
      nameOfBackPage = "EasyPlus";
    }
    if (widget.nameOfPage == "Medium") {
      nameOfBackPage = "Medium";
    }
    if (widget.nameOfPage == "Hard") {
      nameOfBackPage = "Hard";
    }
    if (widget.nameOfPage == "Extreme") {
      nameOfBackPage = "Extreme";
    }
  }

  @override
  void initState() {
    checkBackName(widget.nameOfPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          height: 350,
          width: 300,
          decoration: BoxDecoration(color: Colors.grey[350]),
          child: Column(
            children: [
              Text(
                "GAME OVER",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Lottie.asset("lib/assets/game_over.json", height: 150),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            icon: Icon(Icons.error),
                            title: Text("Your numbers were"),
                            content: Padding(
                              padding: const EdgeInsets.only(left: 75.0),
                              child: Text(
                                widget.randomNumbers
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', '')
                                    .replaceAll(',', ""),
                                style: GoogleFonts.interTight(
                                    color: Colors.black, fontSize: 32),
                              ),
                            ),
                          ));
                },
                child: Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red),
                  child: Center(
                    child: Text(
                      "See numbers",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.nameOfPage == "Easy") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EasyGameMode(),
                        ));
                  }
                  if (widget.nameOfPage == "EasyPlus") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EasyPlusGameMode(),
                        ));
                  }

                  if (widget.nameOfPage == "Medium") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MediumGameMode(),
                        ));
                  }
                  if (widget.nameOfPage == "Hard") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HardGameMode(),
                        ));
                  }
                  if (widget.nameOfPage == "Extreme") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExtremeGameMode(),
                        ));
                  }
                  ;
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.yellow),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Play again",
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.loop)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
