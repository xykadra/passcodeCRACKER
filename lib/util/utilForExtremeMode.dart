import 'package:flutter/material.dart';

class UtilForExtremeMode extends StatefulWidget {
  final String num1;
  final String num2;
  final String num3;
  final String num4;

  final int correctNumbers;
  final int correctSpots;

  final bool isThereDuplicates;
  final int whichNumberIsDuplicate;

  UtilForExtremeMode({
    required this.num1,
    required this.num2,
    required this.num3,
    required this.num4,
    required this.correctNumbers,
    required this.correctSpots,
    required this.isThereDuplicates,
    required this.whichNumberIsDuplicate,
  });

  @override
  State<UtilForExtremeMode> createState() => _UtilForExtremeModeState();
}

class _UtilForExtremeModeState extends State<UtilForExtremeMode> {
  bool numberOneDuplicate = false;
  bool numberTwoDuplicate = false;
  bool numberThreeDuplicate = false;
  bool numberFourDuplicate = false;

  void setStarToDuplicate(int whichNumberIsDuplicate) {
    if (whichNumberIsDuplicate == 0) {
      setState(() {
        numberOneDuplicate = true;
      });
    } else if (whichNumberIsDuplicate == 1) {
      setState(() {
        numberTwoDuplicate = true;
      });
    } else if (whichNumberIsDuplicate == 2) {
      setState(() {
        numberThreeDuplicate = true;
      });
    } else {
      setState(() {
        numberFourDuplicate = true;
      });
    }
  }

  @override
  void initState() {
    widget.isThereDuplicates
        ? setStarToDuplicate(widget.whichNumberIsDuplicate)
        : null;
    print(widget.whichNumberIsDuplicate);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            Container(
              width: 158,
              height: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  // color: Colors.black,
                  //borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white)),
            ),
            Positioned(
              left: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black)),
                      child: Text(
                        widget.num1,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    numberOneDuplicate
                        ? Positioned(
                            top: 2,
                            left: 3,
                            child: Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.black,
                            ))
                        : SizedBox()
                  ]),
                  SizedBox(
                    width: 5,
                  ),
                  Stack(children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black)),
                      child: Text(
                        widget.num2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    numberTwoDuplicate
                        ? Positioned(
                            top: 2,
                            left: 3,
                            child: Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.black,
                            ))
                        : SizedBox(),
                  ]),
                  SizedBox(
                    width: 5,
                  ),
                  Stack(children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black)),
                      child: Text(
                        widget.num3,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    numberThreeDuplicate
                        ? Positioned(
                            top: 2,
                            left: 3,
                            child: Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.black,
                            ))
                        : SizedBox(),
                  ]),
                  SizedBox(
                    width: 5,
                  ),
                  Stack(children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black)),
                      child: Text(
                        widget.num4,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    numberFourDuplicate
                        ? Positioned(
                            top: 2,
                            left: 3,
                            child: Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.black,
                            ))
                        : SizedBox()
                  ]),
                ],
              ),
            )
          ]),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.correctNumbers.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
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
