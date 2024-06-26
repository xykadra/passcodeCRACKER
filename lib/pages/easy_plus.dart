import "dart:math";

import "package:audioplayers/audioplayers.dart";

import "package:awesome_snackbar_content/awesome_snackbar_content.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:passcodecr/Win/GameOver/win_page2.dart";
import "package:passcodecr/choosing_difficulty.dart";
import "package:passcodecr/components/winPageEasyMode.dart";
import "package:passcodecr/pages/game_over_page.dart";

import "package:passcodecr/stateManagement/wins_state.dart";
import 'package:passcodecr/util/utilForEasyPlusMode.dart';
import 'package:passcodecr/util/utilForEasyMode.dart';

class EasyPlusGameMode extends StatefulWidget {
  const EasyPlusGameMode({super.key});

  @override
  State<EasyPlusGameMode> createState() => _EasyPlusGameModeState();
}

class _EasyPlusGameModeState extends State<EasyPlusGameMode> {
  //Lists
  List<int> inputNumbers = [];

  List<Widget> bodyElements = [];
  List<int> numbers = [];
  List<int> randomNumbers = [];

  //color of text "CORRECT/NUMBERS/SPOTS"
  Color colorOfText = Colors.white;
  int counterForWidgets = 0;
  int counterForTries = 4;
  int numberOfTries = 0;

  //array of maps for passing correct numbers and spots widgets Because it is changing its value each time

  List<Map<int, bool>> arrayOfMapsForPresentNumber = [];
  List<Map<int, bool>> arrayOfMapsForCorrectSpot = [];
  List<List<int>> arrayOfListinputNumbers = [];

  void initState() {
    super.initState();
    randomNumbers = _generateRandomNumbers();
    numberOfTries = 0;
  }

  double heigthOfContainer1 = 40;
  double heigthOfContainer2 = 40;
  double heigthOfContainer3 = 40;
  double heigthOfContainer4 = 40;

  void changeHeightOfInputContainer(int containerNum) {
    if (containerNum == 1) {
      setState(() {
        heigthOfContainer1 = 80;
        heigthOfContainer2 = 40;
        heigthOfContainer3 = 40;
        heigthOfContainer4 = 40;
      });
    } else if (containerNum == 2) {
      heigthOfContainer1 = 40;
      heigthOfContainer2 = 55;
      heigthOfContainer3 = 30;
      heigthOfContainer4 = 30;
    } else if (containerNum == 3) {
      heigthOfContainer1 = 40;
      heigthOfContainer2 = 40;
      heigthOfContainer3 = 40;
      heigthOfContainer4 = 55;
    } else if (containerNum == 4) {
      heigthOfContainer1 = 40;
      heigthOfContainer2 = 40;
      heigthOfContainer3 = 40;
      heigthOfContainer4 = 55;
    }
  }

  void _chekForWin(int correctNumbers, int correctSpots) {
    if (correctNumbers == 4 && correctSpots == 4) {
      WinsState.incrementEasyPlusWins();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WinPageEasyMode(
                    nameOfPage: "EasyPlus",
                    randomNumbers: randomNumbers,
                    arrayOfListinputNumbers: arrayOfListinputNumbers,
                    arrayOfMapsForCorrectSpot: arrayOfMapsForCorrectSpot,
                    arrayOfMapsForPresentNumbers: arrayOfMapsForPresentNumber,
                  ),
              fullscreenDialog: true));
    }
  }

  void addBodyElements(String num1, String num2, String num3, String num4,
      int correctNumbers, int correctSpots, int counterForWidgets) {
    counterForWidgets < 4
        ? bodyElements.add(Padding(
            padding: const EdgeInsets.only(
              bottom: 5.0,
            ),
            child: UtilForEasyMode(
              num1: num1,
              num2: num2,
              num3: num3,
              num4: num4,
              isNumberOnCorrectSpot: isNumberOnCorrectSpot,
              isNumberPresent: isNumberPresent,
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
              nameOfPage: "EasyPlus",
              randomNumbers: randomNumbers,
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
      if (!numbers.contains(num)) {
        numbers.add(num);
      }
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

  Map<int, int> checkNumbers(List<int> inputNumbers, List<int> randomNumbers) {
    int correctNumbers = 0;
    int correctSpots = 0;

    for (int i = 0; i < inputNumbers.length; i++) {
      if (randomNumbers.contains(inputNumbers[i])) {
        setState(() {
          isNumberPresent[i] = true;
        });

        correctNumbers++;
      }

      if (inputNumbers[i] == randomNumbers[i]) {
        setState(() {
          isNumberOnCorrectSpot[i] = true;
        });
        correctSpots++;
      }
    }

    //adding to list for every input its corresponding map of present and correct spot numbers
    arrayOfMapsForPresentNumber.add(Map.from(isNumberPresent));
    arrayOfMapsForCorrectSpot.add(Map.from(isNumberOnCorrectSpot));
    arrayOfListinputNumbers.add(List.from(inputNumbers));

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
        title: 'LOL',
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
                        color: Colors.green.withOpacity(0.93)),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Easy',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                        Text(
                          'Plus',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 5),
                        ),
                      ],
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
                      counterForTries = 5;
                      counterForWidgets = 0;

                      //clearing all arrays
                      arrayOfListinputNumbers.clear();
                      arrayOfMapsForCorrectSpot.clear();
                      arrayOfMapsForPresentNumber.clear();
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
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: bodyElements,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Input of numbers
                  GestureDetector(
                    onTap: () {
                      changeHeightOfInputContainer(1);
                    },
                    child: Container(
                      //color: Colors.grey[200],
                      height: heigthOfContainer1,
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
                  ),

                  GestureDetector(
                    onTap: () {
                      changeHeightOfInputContainer(2);
                    },
                    child: Container(
                      //color: Colors.white,
                      height: heigthOfContainer2,
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
                  ),
                  GestureDetector(
                    onTap: () {
                      changeHeightOfInputContainer(3);
                    },
                    child: Container(
                      //color: Colors.deepPurple,
                      height: heigthOfContainer3,
                      width: MediaQuery.of(context).size.width / 6,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: num3Controller,
                        focusNode: _focusNode3,
                        onChanged: (String value) {
                          if (value.isNotEmpty) {
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
                  ),
                  GestureDetector(
                    onTap: () {
                      changeHeightOfInputContainer(4);
                    },
                    child: Container(
                      //color: Colors.deepPurple,
                      height: heigthOfContainer4,
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
                      _handlingOfEmptyFields("RULE 2.");
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
                    color: Colors.green,
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
            Spacer(),

            //Uncomment this for debugging
            Text(
              "Random number: " + randomNumbers.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            // Text(counterForWidgets.toString()),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => EasyPlusGameMode(),
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
            //     child: Text("See present and correct spots"))
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
                  Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.93),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Easy',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                        Text(
                          'Plus',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    )),
                  ),
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
                        "4 tries",
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
