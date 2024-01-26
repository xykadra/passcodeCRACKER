import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WinsState {
  static Future<void> incrementEasyModeWins() async {
    final prefs = await SharedPreferences.getInstance();
    final currentWins = prefs.getInt("total_easy_wins");
    if (currentWins == null) {
      print("Error while incrementing");
    } else {
      prefs.setInt("total_easy_wins", currentWins + 1);
    }
  }

  static Future<void> incrementEasyPlusWins() async {
    final prefs = await SharedPreferences.getInstance();
    final currentWins = prefs.getInt("total_easy_plus_wins");
    if (currentWins == null) {
      print("Error while incrementing");
    } else {
      prefs.setInt("total_easy_plus_wins", currentWins + 1);
    }
  }

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

  static Future<void> incrementExtremeWins() async {
    final prefs = await SharedPreferences.getInstance();
    final currentWins = prefs.getInt("total_extreme_wins");
    if (currentWins == null) {
      print("Error while incrementing");
    } else {
      prefs.setInt("total_extreme_wins", currentWins + 1);
    }
  }
}
