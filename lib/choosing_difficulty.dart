import 'package:flutter/material.dart';
import 'package:passcodecr/pages/easy_game_mode.dart';
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
                      ));
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
                        builder: (context) => MediumGameMode(),
                      ));
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
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
