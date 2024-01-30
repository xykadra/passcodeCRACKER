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
import 'package:passcodecr/util/utilForWinPageEasyMode.dart';

class WinPageEasyMode extends StatefulWidget {
  final List<int> randomNumbers;
  final String nameOfPage;

  final List<List<int>> arrayOfListinputNumbers;
  final List<Map<int, bool>> arrayOfMapsForCorrectSpot;
  final List<Map<int, bool>> arrayOfMapsForPresentNumbers;

  WinPageEasyMode(
      {required this.randomNumbers,
      required this.nameOfPage,
      required this.arrayOfListinputNumbers,
      required this.arrayOfMapsForCorrectSpot,
      required this.arrayOfMapsForPresentNumbers});

  @override
  State<WinPageEasyMode> createState() => _WinPageEasyModeState();
}

class _WinPageEasyModeState extends State<WinPageEasyMode> {
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
    super.initState;
    // printTries();

    checkBackName(widget.nameOfPage);

    // for (int i = 0; i < widget.arrayOfListinputNumbers.length; i++) {
    //   print("Try " +
    //       i.toString() +
    //       " INPUT NUMBERS: " +
    //       widget.arrayOfListinputNumbers[i].toString());
    // }

    // for (int i = 0; i < widget.arrayOfMapsForCorrectSpot.length; i++) {
    //   print("Try " +
    //       i.toString() +
    //       " CORRECT SPOTS: " +
    //       widget.arrayOfMapsForCorrectSpot[i].toString());
    // }
    // for (int i = 0; i < widget.arrayOfMapsForPresentNumbers.length; i++) {
    //   print("Try " +
    //       i.toString() +
    //       " PRESENT NUMBERS: " +
    //       widget.arrayOfMapsForPresentNumbers[i].toString());
    // }
  }

  //This was writen by Mirza Kadric 27.01.2024 1:22
  void printTries() {
    for (int i = 0; i < widget.arrayOfListinputNumbers.length; i++) {
      print(i.toString() + ": " + widget.arrayOfListinputNumbers[i].toString());
    }
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
            // scrollListToButtom();
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

  //Scrolling of tries inside container :D Why not
  final ScrollController _scrollController = ScrollController();

  void scrollListToButtom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
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

            // Spacer(),
            // !isContainerOpen
            //     ? Padding(
            //         padding: const EdgeInsets.all(18.0),
            //         child: Container(
            //           padding: EdgeInsets.all(10),
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //           ),
            //           child: Center(
            //             child: Column(
            //               children: [
            //                 Text(
            //                   "YESS, YOUR NUMBERS WERE",
            //                   style: GoogleFonts.inter(fontSize: 20),
            //                 ),
            //                 Text(
            //                   widget.randomNumbers
            //                       .toString()
            //                       .replaceAll('[', '')
            //                       .replaceAll(']', '')
            //                       .replaceAll(',', ""),
            //                   style: GoogleFonts.inter(
            //                       fontSize: 32, fontWeight: FontWeight.bold),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       )
            //     : SizedBox(),

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
                          isContainerOpen
                              ? Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "YESS, YOUR NUMBERS WERE",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.randomNumbers
                                            .toString()
                                            .replaceAll('[', '')
                                            .replaceAll(']', '')
                                            .replaceAll(',', ""),
                                        style: GoogleFonts.inter(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
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
                                    : Container(),
                                showContentInsideContainer
                                    ? Text(
                                        "It took you " +
                                            messageForOpenedContainer(widget
                                                .arrayOfListinputNumbers
                                                .length) +
                                            " to crack code",
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Container(),
                                // showContentInsideContainer
                                //     ? Icon(
                                //         Icons.close_fullscreen_rounded,
                                //         size: 30,
                                //       )
                                //     : Container(),
                                !isContainerOpen
                                    ? Icon(
                                        Icons.more_horiz,
                                        size: 40,
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          showContentInsideContainer
                              ? Column(
                                  children: [
                                    nameOfBackPage == "Easy" &&
                                            nameOfBackPage == "EasyPlus"
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("      NUMBER",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          Text("SPOTS",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    Container(
                                      height: 300,
                                      //color: Colors.red,
                                      child: ListView.builder(
                                          itemCount: widget
                                              .arrayOfListinputNumbers.length,
                                          itemBuilder: ((context, index) {
                                            return UtilForWinPageEasyMode(
                                              num1: widget
                                                  .arrayOfListinputNumbers[
                                                      index]
                                                  .elementAt(0)
                                                  .toString(),
                                              num2: widget
                                                  .arrayOfListinputNumbers[
                                                      index]
                                                  .elementAt(1)
                                                  .toString(),
                                              num3: widget
                                                  .arrayOfListinputNumbers[
                                                      index]
                                                  .elementAt(2)
                                                  .toString(),
                                              num4: widget
                                                  .arrayOfListinputNumbers[
                                                      index]
                                                  .elementAt(3)
                                                  .toString(),
                                              isNumberOnCorrectSpot: widget
                                                  .arrayOfMapsForCorrectSpot
                                                  .elementAt(index),
                                              isNumberPresent: widget
                                                  .arrayOfMapsForPresentNumbers
                                                  .elementAt(index),
                                            );
                                          })),
                                    ),
                                    // Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: 20.0),
                                    //     child: Container(
                                    //       height: 400,
                                    //       child: ListView.builder(
                                    //           itemCount: 3,
                                    //           itemBuilder: ((context, index) {
                                    //             return UtilForWinPageEasyMode(
                                    //               num1: 1.toString(),
                                    //               num2: 2.toString(),
                                    //               num3: 3.toString(),
                                    //               num4: 4.toString(),
                                    //               isNumberOnCorrectSpot: {
                                    //                 0: false,
                                    //                 1: false,
                                    //                 3: true,
                                    //                 4: false
                                    //               },
                                    //               isNumberPresent: {
                                    //                 0: true,
                                    //                 1: false,
                                    //                 3: false,
                                    //                 4: false
                                    //               },
                                    //             );
                                    //           })),
                                    //     )),
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
                          fullscreenDialog: true));
                }
                if (widget.nameOfPage == "EasyPlus") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EasyPlusGameMode(),
                          fullscreenDialog: true));
                }

                if (widget.nameOfPage == "Medium") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MediumGameMode(),
                          fullscreenDialog: true));
                }
                if (widget.nameOfPage == "Hard") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HardGameMode(),
                          fullscreenDialog: true));
                }
                if (widget.nameOfPage == "Extreme") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExtremeGameMode(),
                          fullscreenDialog: true));
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
          ],
        )),
      ),
    );
  }
}
