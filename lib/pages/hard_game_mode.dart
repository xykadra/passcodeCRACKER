import "dart:math";

import "package:audioplayers/audioplayers.dart";

import "package:awesome_snackbar_content/awesome_snackbar_content.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:passcodecr/Win/GameOver/win_page2.dart";
import "package:passcodecr/choosing_difficulty.dart";
import "package:passcodecr/pages/game_over_page.dart";

import "package:passcodecr/stateManagement/wins_state.dart";
import 'package:passcodecr/util/utilForEasyPlusMode.dart';
import "package:passcodecr/util/utilForHardMode.dart";
import "package:passcodecr/util/utilForMediumMode.dart";

class HardGameMode extends StatefulWidget {
  const HardGameMode({super.key});

  @override
  State<HardGameMode> createState() => _HardGameModeState();
}

class _HardGameModeState extends State<HardGameMode> {
  //Lists
  List<int> inputNumbers = [];

  List<Widget> bodyElements = [];
  List<int> numbers = [];
  List<int> randomNumbers = [];

  //color of text "CORRECT/NUMBERS/SPOTS"
  Color colorOfText = Colors.white;
  int counterForWidgets = 0;
  int counterForTries = 8;
  int numberOfTries = 0;

  void initState() {
    super.initState();
    randomNumbers = _generateRandomNumbers();
    numberOfTries = 0;
  }

  void _chekForWin(int correctNumbers, int correctSpots) {
    if (correctNumbers == 4 && correctSpots == 4) {
      WinsState.incrementHardWins();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WinPage2(
                    nameOfPage: "Hard",
                    randomNumbers: randomNumbers,
                    tries: bodyElements,
                    numerOfTries: numberOfTries,
                    inputTries: [],
                  ),
              fullscreenDialog: true));
    }
  }

  void addBodyElements(String num1, String num2, String num3, String num4,
      int correctNumbers, int correctSpots, int counterForWidgets) {
    counterForWidgets < 8
        ? bodyElements.add(Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: UtilForHardMode(
              num1: num1,
              num2: num2,
              num3: num3,
              num4: num4,
              correctNumbers: correctNumbers,
              correctSpots: correctSpots,
            ),
          ))
        : _navigateToGameOverPage(randomNumbers);
  }

  void _navigateToGameOverPage(List<int> randomNumbers) {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameOverPage(
              randomNumbers: randomNumbers,
              nameOfPage: "Hard",
            ),
          ));
    });
  }

  //Functions that returns list of 4 random numbers

  List<int> _generateRandomNumbers() {
    Random random = Random();
    List<int> numbers = [];

    while (numbers.length < 4) {
      int num = random.nextInt(9) + 1;
      numbers.add(num);
    }
    return numbers;
  }

  void _generateNewRandomNumbers() {
    setState(() {
      randomNumbers = _generateRandomNumbers();
    });
  }

  //controllers for input fields
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  final TextEditingController num3Controller = TextEditingController();
  final TextEditingController num4Controller = TextEditingController();
  //focus nodes for input fields
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();

  // bool isNumber1Present = false;
  // bool isNumber1OnCorrectSpot = false;

  // bool isNumber2Present = false;
  // bool isNumber2OnCorrectSpot = false;

  // bool isNumber3Present = false;
  // bool isNumber3OnCorrectSpot = false;

  // bool isNumber4Present = false;
  // bool isNumber4OnCorrectSpot = false;

  // Map<int, int> checkNumbers(List<int> inputNumbers, List<int> randomNumbers) {
  //   int correctNumbers = 0;
  //   int correctSpots = 0;

  //   for (int i = 0; i < inputNumbers.length; i++) {
  //     if (randomNumbers.contains(inputNumbers[i])) {
  //       if (i == 0) {
  //         setState(() {
  //           isNumber1Present = true;
  //         });
  //       }
  //       if (i == 1) {
  //         setState(() {
  //           isNumber2Present = true;
  //         });
  //       }
  //       correctNumbers++;
  //     }

  //     if (inputNumbers[i] == randomNumbers[i]) {
  //       correctSpots++;
  //     }
  //   }

  //   return {correctNumbers: correctSpots};
  // }

  Map<int, bool> isNumberPresent = {
    0: false,
    1: false,
    2: false,
    3: false,
  };

  Map<int, bool> isNumberOnCorrectSpot = {
    0: false,
    1: false,
    2: false,
    3: false,
  };

//Implementing logic, theat will count occurance of each number in list
//If there is more that 0 occurance of every number that count for correct numbers does not count

  int occuranceOfNumber1 = 0;
  int occuranceOfNumber2 = 0;
  int occuranceOfNumber3 = 0;
  int occuranceOfNumber4 = 0;

  Map<int, int> occurances = {
    0: 0,
    1: 0,
    2: 0,
    3: 0,
  };

  void incrementOccurrence(int number, Map<int, int> occurrences) {
    // Increment the occurrence of the specified number
    // occurrences?.update(number, (value) => value + 1, ifAbsent: () => 1);
    //occurances[number].

    occurances[number] = (occurances[number] ?? 0) + 1;
  }

  void resetOccurances(Map<int, int> list) {
    setState(() {
      occuranceOfNumber1 = 0;
      occuranceOfNumber2 = 0;
      occuranceOfNumber3 = 0;
      occuranceOfNumber4 = 0;
    });

    list.forEach((key, value) {
      list[key] = 0;
    });
  }

  void addValueToOccurances(int key, int value) {
    if (key == 0) {
      setState(() {
        occuranceOfNumber1 = value;
      });
    }
    if (key == 1) {
      setState(() {
        occuranceOfNumber2 = value;
      });
    }
    if (key == 2) {
      setState(() {
        occuranceOfNumber3 = value;
      });
    }
    if (key == 3) {
      setState(() {
        occuranceOfNumber4 = value;
      });
    }
  }

  void checkIsThereRepeatingNumbers(List<int> randomNumbers) {
    resetOccurances(occurances);
    for (int i = 0; i < randomNumbers.length; i++) {
      for (int j = 0; j < randomNumbers.length; j++) {
        if (inputNumbers[i] == randomNumbers[j]) {
          //occurance for randomNumber[i] has happened once
          //value of occuranceNumber1 should be incremented
          //we need to return value of number that has occured
          //multiple times
          incrementOccurrence(i, occurances);
        }
      }
    }

    //checking if there is some number that occurance has
    //happened multiple times
    for (int k = 0; k < 3; k++) {
      occurances.forEach((key, value) {
        addValueToOccurances(key, value);
      });
    }
    print("Occurances:");
    print("Occurance of Number 1: " + occuranceOfNumber1.toString());
    print("Occurance of Number 2: " + occuranceOfNumber2.toString());
    print("Occurance of Number 3: " + occuranceOfNumber3.toString());
    print("Occurance of Number 4: " + occuranceOfNumber4.toString());
  }

  Map<int, int> checkNumbers(List<int> inputNumbers, List<int> randomNumbers) {
    int correctNumbers = 0;
    int correctSpots = 0;

//takes every number and compares to every other number from list
//if there is more than one occurance in list it should not be counted as correctNumber

//break Should Be implemented but not

//If num1 have more than one occurances then correct number should be
//if number have more occurances and correct numbers

    for (int i = 0; i < inputNumbers.length; i++) {
      if (randomNumbers.contains(inputNumbers[i])) {
        correctNumbers++;
      }
      if (inputNumbers[i] == randomNumbers[i]) {
        correctSpots++;
      }
      // if (inputNumbers[i] == randomNumbers[i]) {
      //   correctSpots++;
      // }
    }
    return {correctNumbers: correctSpots};
  }

  Map<int, int> result = Map.from({1: 0, 2: 0});

  void checkInput() {
    result = checkNumbers(inputNumbers, randomNumbers);
  }

  void _checkForSpotSound(int rightSpots) {
    if (rightSpots > 0) {
      //play sound

      setState(() {
        AudioPlayer().play(AssetSource("win_sound.mp3"), volume: 20);
      });
    }
  }

  void _handlingOfEmptyFields(String message) {
    final materialBanner = MaterialBanner(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        color: Colors.red[350],
        title: 'Oh Hey!!',
        message: message,
        messageFontSize: 18,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
        // to configure for material banner
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }

  bool hasTwoSameNumbers(int a, int b, int c, int d) {
    return a == b || a == c || a == d || b == c || b == d || c == d;
  }

  bool isAnyNumerZeor(int a, int b, int c, int d) {
    return a == 0 || b == 0 || c == 0 || d == 0;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    dialog(context);
                  },
                  child: Container(
                    color: Colors.grey[200],
                    height: 30,
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.info,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                    color: Colors.grey[200],
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: Text(
                        "Tries remaining: " + counterForTries.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    changeGameMode(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.red),
                    child: Center(
                        child: Text(
                      'Hard',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      colorOfText = Colors.white;
                      bodyElements.clear();
                      _generateNewRandomNumbers();
                      num1Controller.text = "";
                      num2Controller.text = "";
                      num3Controller.text = "";
                      num4Controller.text = "";
                      inputNumbers.clear();
                      counterForTries = 8;
                      counterForWidgets = 0;
                    });
                  },
                  child: Container(
                    color: Colors.red,
                    height: 30,
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  padding: EdgeInsets.all(10),
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Text("CORRECT",
                          style: TextStyle(
                              color: colorOfText,
                              fontWeight: FontWeight.bold,
                              fontSize: 24)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("  NUMBER",
                                style: TextStyle(color: colorOfText)),
                            Text("SPOTS", style: TextStyle(color: colorOfText)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: bodyElements,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Input of numbers
                  Container(
                    //color: Colors.grey[200],
                    height: 40,
                    width: MediaQuery.of(context).size.width / 6,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: num1Controller,
                      focusNode: _focusNode1,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          _focusNode1.unfocus();
                          FocusScope.of(context).requestFocus(_focusNode2);
                        }
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black)),
                        counterText: "",
                      ),
                    ),
                  ),

                  Container(
                    //color: Colors.white,
                    height: 40,
                    width: MediaQuery.of(context).size.width / 6,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: num2Controller,
                      focusNode: _focusNode2,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          _focusNode2.unfocus();
                          FocusScope.of(context).requestFocus(_focusNode3);
                        }
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black)),
                        counterText: "",
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.deepPurple,
                    height: 40,
                    width: MediaQuery.of(context).size.width / 6,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: num3Controller,
                      focusNode: _focusNode3,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          print("kurac");
                          _focusNode3.unfocus();
                          FocusScope.of(context).requestFocus(_focusNode4);
                        }
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black)),
                        counterText: "",
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.deepPurple,
                    height: 40,
                    width: MediaQuery.of(context).size.width / 6,
                    child: TextFormField(
                      //textInputAction: TextInputAction.next,
                      controller: num4Controller,
                      focusNode: _focusNode4,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          _focusNode4.unfocus();
                        }
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.black)),
                        counterText: "",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    //clearing list input numbers and then adding new numbers to it
                    inputNumbers.clear();
                    //my way of handling parse error
                    if (num1Controller.text == "" ||
                        num2Controller.text == "" ||
                        num3Controller.text == "" ||
                        num4Controller.text == "") {
                      _handlingOfEmptyFields("You didn't input some values");
                    } else if (isAnyNumerZeor(
                        int.parse(num1Controller.text),
                        int.parse(num2Controller.text),
                        int.parse(num3Controller.text),
                        int.parse(num4Controller.text))) {
                      _handlingOfEmptyFields("RULE 1.");
                    }
                    //To be implemented maybe
                    // else if (hasTwoSameNumbers(
                    //         int.parse(num1Controller.text),
                    //         int.parse(num2Controller.text),
                    //         int.parse(num3Controller.text),
                    //         int.parse(num4Controller.text)) ==
                    //     true) {
                    //   _handlingOfEmptyFields(
                    //       "There are two or more same numbers!");
                    // } else if (num1Controller.text == "0" ||
                    //     num2Controller.text == "0" ||
                    //     num3Controller.text == "0" ||
                    //     num4Controller.text == "0") {
                    //   _handlingOfEmptyFields("Somewhere zero?");
                    // }
                    else {
                      isNumberPresent[0] = false;
                      isNumberPresent[1] = false;
                      isNumberPresent[2] = false;
                      isNumberPresent[3] = false;

                      isNumberOnCorrectSpot[0] = false;
                      isNumberOnCorrectSpot[1] = false;
                      isNumberOnCorrectSpot[2] = false;
                      isNumberOnCorrectSpot[3] = false;

                      //making visiable correct numbers and correct spots
                      colorOfText = Colors.black;

                      inputNumbers.add(int.parse(num1Controller.text));
                      inputNumbers.add(int.parse(num2Controller.text));
                      inputNumbers.add(int.parse(num3Controller.text));
                      inputNumbers.add(int.parse(num4Controller.text));

                      //function that checks input and returing correct numbers and correct spots
                      checkInput();

                      //adding widgets
                      addBodyElements(
                        num1Controller.text,
                        num2Controller.text,
                        num3Controller.text,
                        num4Controller.text,
                        result.keys.first,
                        result.values.first,
                        counterForWidgets,
                      );

                      _checkForSpotSound(result.values.first);

                      _chekForWin(result.keys.first, result.values.first);

                      //making forms clear
                      num1Controller.text = "";
                      num2Controller.text = "";
                      num3Controller.text = "";
                      num4Controller.text = "";

                      //counter for widgets
                      counterForWidgets++;
                      counterForTries--;
                      numberOfTries++;
                    }
                  });
                },
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Try",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //Uncomment this for debugging
            // Text(
            //   "Random number: " + randomNumbers.toString(),
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 25,
            //       fontWeight: FontWeight.bold),
            // ),
            // Text(counterForWidgets.toString()),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => HardGameMode(),
            //           ));
            //     },
            //     child: Text("Generate new numbers")),
            // ElevatedButton(
            //     onPressed: () {
            //       //Testing
            //       print("Printing numbers if they are present");
            //       print(isNumberPresent);
            //       print("Printing numbers if they are on correct  spot");
            //       print(isNumberOnCorrectSpot);
            //     },
            //     child: Text("See present and correct spots")),
            // ElevatedButton(
            //     onPressed: () {
            //       //Testing
            //       checkIsThereRepeatingNumbers(randomNumbers);
            //     },
            //     child: Text("Check repeating numbers")),

            Spacer(),
          ],
        ),
      )),
    ));
  }

  Future<dynamic> dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(2),
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Text(
                      "I understood",
                      style: GoogleFonts.sourceCodePro(
                          color: Colors.white, fontSize: 25),
                    )),
                  ),
                ),
              ],
              icon: Icon(Icons.error),
              title: Text("How to play PASSCODE CRACKER?"),
              content: Column(
                children: [
                  Stack(children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            "Hard",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black,
                          ),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text(
                                "+",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                " repeating numbers",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ))
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        "8 tries",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "In the input fields enter numbers in range 1 to 9, and try to crack code!",
                    style: GoogleFonts.sourceCodePro(
                        color: Colors.black, fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Game will give you hint how many numbers you did right and how many of them are in right spot.",
                    style: GoogleFonts.sourceCodePro(
                        color: Colors.black, fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "RULES",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "1. DO NOT ENTER ZERO",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "2. DO NOT PRESS TRY WITHOUT INPUTING SOME NUMBERS",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ));
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
