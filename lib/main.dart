import 'package:flutter/material.dart';
import 'package:passcodecr/choosing_difficulty.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  int initialEasyWins = prefs.getInt("total_easy_wins") ?? 0;
  await prefs.setInt("total_easy_wins", initialEasyWins);

  int initialEasyPlusWins = prefs.getInt("total_easy_plus_wins") ?? 0;
  await prefs.setInt("total_easy_plus_wins", initialEasyPlusWins);
  // Check if total_medium_wins exists, otherwise set it to 0
  int initialMediumWins = prefs.getInt("total_medium_wins") ?? 0;
  await prefs.setInt("total_medium_wins", initialMediumWins);

  // Check if total_hard_wins exists, otherwise set it to 0
  int initialHardWins = prefs.getInt("total_hard_wins") ?? 0;
  await prefs.setInt("total_hard_wins", initialHardWins);

  int initialExtremeWins = prefs.getInt("total_extreme_wins") ?? 0;
  await prefs.setInt("total_extreme_wins", initialExtremeWins);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChoosingDifficulty(),
    );
  }
}
