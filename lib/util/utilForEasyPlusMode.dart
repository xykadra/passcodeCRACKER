import 'package:flutter/material.dart';

class UtilForAdditionalWidgets extends StatefulWidget {
  final String num1;
  final String num2;
  final String num3;
  final String num4;

  final int correctNumbers;
  final int correctSpots;

  final Map<int, bool> isNumberOnCorrectSpot;
  final Map<int, bool> isNumberPresent;

  UtilForAdditionalWidgets(
      {required this.num1,
      required this.num2,
      required this.num3,
      required this.num4,
      required this.correctNumbers,
      required this.correctSpots,
      required this.isNumberOnCorrectSpot,
      required this.isNumberPresent});

  @override
  State<UtilForAdditionalWidgets> createState() =>
      _UtilForAdditionalWidgetsState();
}

class _UtilForAdditionalWidgetsState extends State<UtilForAdditionalWidgets> {
  //if number is on right spot GREEN if that number is somewhere but not on

  //moram za svaki znati isPresent is isOnCorrectSpot

  Color getColorForNumberContainer(int number) {
    bool isPresent = widget.isNumberPresent[number] ?? false;
    bool isOnCorrectSpot = widget.isNumberOnCorrectSpot[number] ?? false;

    if (isOnCorrectSpot) {
      return Colors.green;
    } else if (isPresent) {
      return Colors.yellow;
    } else {
      return Colors.black;
    }
  }

  Color getColorForNumber(int number) {
    bool isPresent = widget.isNumberPresent[number] ?? false;
    bool isOnCorrectSpot = widget.isNumberOnCorrectSpot[number] ?? false;

    if (isOnCorrectSpot) {
      return Colors.white;
    } else if (isPresent) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: getColorForNumberContainer(0),
                    ),
                    child: Text(
                      widget.num1,
                      style: TextStyle(
                          color: getColorForNumber(0),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: getColorForNumberContainer(1),
                    ),
                    child: Text(
                      widget.num2,
                      style: TextStyle(
                          color: getColorForNumber(1),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: getColorForNumberContainer(2),
                    ),
                    child: Text(
                      widget.num3,
                      style: TextStyle(
                          color: getColorForNumber(2),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: getColorForNumberContainer(3),
                    ),
                    child: Text(
                      widget.num4,
                      style: TextStyle(
                          color: getColorForNumber(3),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.correctNumbers.toString(),
                  style: TextStyle(
                      color: getColorForNumber(4),
                      fontSize: 24,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.correctSpots.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
