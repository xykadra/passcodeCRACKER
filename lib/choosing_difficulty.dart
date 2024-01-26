import 'package:flutter/material.dart';
import 'package:passcodecr/pages/easy_game_mode.dart';
import 'package:passcodecr/pages/easy_plus.dart';
import 'package:passcodecr/pages/extreme_game_mode.dart';
import 'package:passcodecr/pages/hard_game_mode.dart';
import 'package:passcodecr/pages/medium_game_mode.dart';
import 'package:passcodecr/stateManagement/wins_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoosingDifficulty extends StatefulWidget {
  const ChoosingDifficulty({super.key});

  @override
  State<ChoosingDifficulty> createState() => _ChoosingDifficultyState();
}

class _ChoosingDifficultyState extends State<ChoosingDifficulty> {
  int totalEasyWins = 0;
  int totalEasyPlusWins = 0;
  int totalMediumWins = 0;
  int totalHardWins = 0;
  int totalExtremeMode = 0;

  void initState() {
    super.initState();
    _fetchWins();
  }

  Future<void> _fetchWins() async {
    int easyWins = await getTotalWins("total_easy_wins");
    int easyPlusWins = await getTotalWins("total_easy_plus_wins");
    int mediumWins = await getTotalWins("total_medium_wins");
    int hardWins = await getTotalWins("total_hard_wins");
    int extremeWins = await getTotalWins("total_extreme_wins");

    setState(() {
      totalEasyWins = easyWins;
      totalEasyPlusWins = easyPlusWins;
      totalMediumWins = mediumWins;
      totalHardWins = hardWins;
      totalExtremeMode = extremeWins;
    });
  }

  Future<int> getTotalWins(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final wins = prefs.getInt(key);
    if (wins == null) {
      return 0;
    }
    return wins;
  }

  Future<void> _restartWins() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("total_medium_wins", 0);
    pref.setInt("total_hard_wins", 0);
  }

  Future<void> _unlockHardExtremeMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("total_medium_wins", 10);
    pref.setInt("total_hard_wins", 10);
  }

  Future<void> _unlockHardMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("total_medium_wins", 10);
  }

  bool unlockedStatusHard() {
    if (totalMediumWins < 10) {
      return false;
    } else {
      return true;
    }
  }

  bool unlockedStatusExtreme() {
    if (totalHardWins < 10) {
      return false;
    } else {
      return true;
    }
  }

  int getHowManyMoreMediumWins() {
    return 10 - totalMediumWins;
  }

  int getHowManyMoreHardWins() {
    return 10 - totalHardWins;
  }

  Future<dynamic> cannotStartHardModeDialog(
      BuildContext context, String HowManyMoreMediumWins) {
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
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
                  ),
                ),
              ],
              title: Text(
                "You need to win " +
                    HowManyMoreMediumWins +
                    " more medium games to unlock HARD MODE",
                textAlign: TextAlign.center,
              ),
            ));
  }

  Future<dynamic> cannotStartExtremeModeDialog(
      BuildContext context, String HowManyMoreHardWins) {
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
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
                  ),
                ),
              ],
              //icon: Icon(Icons.airline_seat_legroom_extra_outlined),
              title: Text(
                "You need to win " +
                    HowManyMoreHardWins +
                    " more hard games to unlock EXTREME MODE",
                textAlign: TextAlign.center,
              ),
            ));
  }

  Future<dynamic> userStats(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Column(
                children: [
                  Text(
                    "User Stats",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  Table(
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      // TableRow(
                      //   decoration: BoxDecoration(color: Colors.black),
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Text(
                      //         'Mode',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Text(
                      //         'Wins',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      TableRow(
                        decoration: BoxDecoration(color: Colors.green),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Easy'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              totalEasyWins.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(color: Colors.green),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'EasyPlus',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              totalEasyPlusWins.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(color: Colors.orange),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Medium',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              totalMediumWins.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(color: Colors.red),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Hard',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              totalHardWins.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(color: Colors.deepPurple),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Extreme',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              totalExtremeMode.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Text(
                  "PasscodeCRACKER",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EasyGameMode(),
                            fullscreenDialog: true));
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 60,
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.green),
                    child: Center(
                        child: Text(
                      'Easy',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EasyPlusGameMode(),
                            fullscreenDialog: true));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 40,
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black),
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
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            'Plus',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ],
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    //WinsState.incrementMediumWins();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MediumGameMode(),
                            fullscreenDialog: true));
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orange),
                    child: Center(
                        child: Text(
                      'Medium',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      unlockedStatusHard()
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HardGameMode(),
                                  fullscreenDialog: true))
                          : cannotStartHardModeDialog(
                              context, getHowManyMoreMediumWins().toString());
                    },
                    child: Stack(children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 60,
                        decoration: BoxDecoration(
                            //border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                            color: unlockedStatusHard()
                                ? Colors.red
                                : Colors.red.withOpacity(0.5)),
                        child: Center(
                            child: Text(
                          'Hard',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black),
                        )),
                      ),
                      !unlockedStatusHard()
                          ? Positioned(
                              top: 8,
                              right: 8,
                              child: Row(
                                children: [
                                  Text(
                                    totalMediumWins.toString() + "/10",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                  Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ],
                              ))
                          : Container()
                    ])),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      unlockedStatusExtreme()
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExtremeGameMode(),
                                  fullscreenDialog: true))
                          : cannotStartExtremeModeDialog(
                              context, getHowManyMoreHardWins().toString());
                    },
                    child: Stack(children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 60,
                        decoration: BoxDecoration(
                            //border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                            color: unlockedStatusExtreme()
                                ? Colors.purple
                                : Colors.purple.withOpacity(0.4)),
                        child: Center(
                            child: Text(
                          'Extreme',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        )),
                      ),
                      !unlockedStatusExtreme()
                          ? Positioned(
                              top: 8,
                              right: 8,
                              child: Row(
                                children: [
                                  Text(
                                    totalHardWins.toString() + "/10",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                  Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ],
                              ))
                          : Container()
                    ])),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: 50,
            left: 20,
            child: ElevatedButton(
                onPressed: () {
                  _restartWins();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChoosingDifficulty(),
                          fullscreenDialog: true));
                },
                child: Text("Lock Hard and Extreme Mode"))),
        Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () {
                userStats(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
              ),
            )),
        Positioned(
            bottom: 50,
            right: 20,
            child: ElevatedButton(
                onPressed: () {
                  _unlockHardExtremeMode();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChoosingDifficulty(),
                          fullscreenDialog: true));
                },
                child: Text("Unlock Hard and Extreme Mode"))),
        Positioned(
            bottom: 100,
            right: 20,
            child: ElevatedButton(
                onPressed: () {
                  _unlockHardMode();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChoosingDifficulty(),
                          fullscreenDialog: true));
                },
                child: Text("Unlock Hard Mode")))
      ]),
    );
  }
}
