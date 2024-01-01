import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WinsState {
  static Future<void> incrementMediumWins() async {
    final prefs = await SharedPreferences.getInstance();
    final currentWins = prefs.getInt("total_medium_wins");
    if (currentWins == null) {
      print("Error while incrementing");
    } else {
      prefs.setInt("total_medium_wins", currentWins + 1);
    }
  }

  static Future<void> incrementHardWins() async {
    final prefs = await SharedPreferences.getInstance();
    final currentWins = prefs.getInt("total_hard_wins");
    if (currentWins == null) {
      print("Error while incrementing");
    } else {
      prefs.setInt("total_hard_wins", currentWins + 1);
    }
  }
  
}
