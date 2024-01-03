import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:passcodecr/choosing_difficulty.dart';

import 'package:passcodecr/pages/easy_game_mode.dart';
import 'package:passcodecr/pages/easy_plus.dart';
import 'package:passcodecr/pages/extreme_game_mode.dart';
import 'package:passcodecr/pages/hard_game_mode.dart';
import 'package:passcodecr/pages/medium_game_mode.dart';

class WinPage2 extends StatefulWidget {
  final List<int> randomNumbers;
  final String nameOfPage;
  final List<Widget> tries;
  final int numerOfTries;

  WinPage2({
    required this.randomNumbers,
    required this.nameOfPage,
    required this.tries,
    required this.numerOfTries,
  });

  @override
  State<WinPage2> createState() => _WinPage2State();
}

class _WinPage2State extends State<WinPage2> {
  String nameOfBackPage = "";

  void checkBackName(String nameOfPage) {
    if (nameOfPage == "Easy") {
      nameOfBackPage = "Easy";
    }
    if (nameOfPage == "EasyPlus") {
      nameOfBackPage = "😀";
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
    super.initState;
    checkBackName(widget.nameOfPage);
  }

  double heigtOfShowStepsContainer = 42;

  bool isContainerOpen = false;
  bool showContentInsideContainer = false;
  double topPadding = 0;
  double horizontalPadding = 50;

  void openCloseShowStepsContainer() {
    if (heigtOfShowStepsContainer == 42) {
      setState(() {
        isContainerOpen = true;
        topPadding = 10;
        horizontalPadding = 20;
        heigtOfShowStepsContainer = 400;
        Timer(Duration(milliseconds: 500), () {
          setState(() {
            showContentInsideContainer = true;
          });
        });
      });
    } else {
      setState(() {
        isContainerOpen = false;
        showContentInsideContainer = false;
        topPadding = 0;
        horizontalPadding = 50;
        heigtOfShowStepsContainer = 42;
      });
    }
  }

  String messageForOpenedContainer(int numberOfTries) {
    if (numberOfTries == 1) {
      return "$numberOfTries try";
    } else {
      return "$numberOfTries tries";
    }
  }

  Future<dynamic> changeGameMode(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChoosingDifficulty(),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(2),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text(
                      "Yes",
                      style: GoogleFonts.sourceCodePro(
                          color: Colors.white, fontSize: 25),
                    )),
                  ),
                ),
              ],
              icon: Icon(Icons.error),
              title: Text("Do you want to change Game MODE?"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   nameOfBackPage,
            //   style: GoogleFonts.sourceCodePro(
            //       fontSize: 40, fontWeight: FontWeight.bold),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Column(
            //     children: tries,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(18.0),
            //   child: Container(
            //     padding: EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //     ),
            //     child: Center(
            //       child: Column(
            //         children: [
            //           Text(
            //             "YESS, YOUR NUMBERS WERE",
            //             style: GoogleFonts.inter(fontSize: 20),
            //           ),
            //           Text(
            //             randomNumbers
            //                 .toString()
            //                 .replaceAll('[', '')
            //                 .replaceAll(']', '')
            //                 .replaceAll(',', ""),
            //             style: GoogleFonts.inter(
            //                 fontSize: 32, fontWeight: FontWeight.bold),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            // Lottie.asset(
            //   "lib/assets/win.json",
            // ),
            Spacer(),
            SizedBox(
              height: 35,
            ),
            Text(
              "YOU WON!!!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: GestureDetector(
                onTap: openCloseShowStepsContainer,
                child: Stack(children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: heigtOfShowStepsContainer,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: topPadding),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                !isContainerOpen
                                    ? Text(
                                        "Show Steps",
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "It took you " +
                                            messageForOpenedContainer(
                                                widget.numerOfTries) +
                                            " to crack code",
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                !isContainerOpen
                                    ? Icon(
                                        Icons.more_horiz,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.close_fullscreen,
                                        size: 30,
                                      )
                              ],
                            ),
                          ),
                          showContentInsideContainer
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 200,
                                          padding: EdgeInsets.all(10),
                                          //color: Colors.red,
                                          child: Column(
                                            children: [
                                              Text("    CORRECT",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24)),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("      NUMBER",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    Text("SPOTS",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        children: widget.tries,
                                      ),
                                    ),
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Spacer(),
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
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green),
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
            Spacer(),
            // SizedBox(
            //   height: 15,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: GestureDetector(
                onTap: () {
                  changeGameMode(context);
                },
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
                          "Change Game Mode",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        // Icon(
                        //   Icons.loop,
                        //   size: 40,
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Lottie.asset("lib/assets/win.json")
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
