import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgColor = Colors.white;
  static Color mainColor = Colors.blue.shade900;
  static Color maccentColor = Colors.blueAccent;

  static List<Color> cardsColor = [
    Colors.redAccent.shade100,
    Colors.blueAccent.shade100,
    Colors.orange.shade400,
    Colors.green.shade400,
  ];

  static TextStyle mainTitle =
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  static TextStyle mainContent = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );

  static TextStyle dateTitle = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
  );
}
