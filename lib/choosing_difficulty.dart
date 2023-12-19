import 'package:flutter/material.dart';
import 'package:passcodecr/pages/easy_game_mode.dart';
import 'package:passcodecr/pages/easy_plus.dart';
import 'package:passcodecr/pages/hard_game_mode.dart';
import 'package:passcodecr/pages/medium_game_mode.dart';

class ChoosingDifficulty extends StatefulWidget {
  const ChoosingDifficulty({super.key});

  @override
  State<ChoosingDifficulty> createState() => _ChoosingDifficultyState();
}

class _ChoosingDifficultyState extends State<ChoosingDifficulty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green),
                  child: Center(
                      child: Text(
                    'Easy',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  )),
                ),
              ),
              SizedBox(
                height: 10,
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
                  padding: const EdgeInsets.only(left: 100.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
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
                height: 10,
              ),
              GestureDetector(
                onTap: () {
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
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.orange),
                  child: Center(
                      child: Text(
                    'Medium',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HardGameMode(),
                          fullscreenDialog: true));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red),
                  child: Center(
                      child: Text(
                    'Hard',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
