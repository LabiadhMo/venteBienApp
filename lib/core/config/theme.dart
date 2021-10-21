import 'package:flutter/material.dart';

class AppTheme {
  static const Color kprimaryColor = Color(0xFF1EC501);
  static const Color ksecondaryColor = Color.fromRGBO(0, 96, 162, 1);

  static const Color kgradient1 = Color(0xFF31576D);
  static const Color kgradient2 = Color(0xFF002E63);
  static const Color kwhiteBlue = Color(0xFF1588CA);
  static const Color kAppBarGradient1 = Color(0xFF0F9153);
  static const Color kAppBarGradient2 = Color.fromRGBO(0, 96, 162, 1);

  static TextStyle titleBlackBoldTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Multi',
    fontWeight: FontWeight.w800,
    height: 1.2,
  );
  static TextStyle formTitleBlackBoldTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 13,
    fontFamily: 'Multi',
    fontWeight: FontWeight.w800,
    height: 1.3,
  );

  static TextStyle appBarTitleTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: "Multi",
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.7,
    height: 1.2,
  );
  static TextStyle homeSubTitleTextStyle = TextStyle(
    color: ksecondaryColor,
    fontFamily: "Multi",
    fontSize: 11,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: "Multi",
    fontSize: 11,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    height: 1.2,
  );
  static TextStyle drawerTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Multi',
    fontSize: 13,
  );
  static TextStyle buttonExtraBoldTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Multi',
    fontSize: 11,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
    height: 1.2,
  );
  static TextStyle smallTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Multi',
    fontSize: 10,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
    height: 1.25,
  );
  static TextStyle smallBlackTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Multi',
    fontSize: 10,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.25,
  );
  static TextStyle smallBoldBlackTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Multi',
    fontSize: 10,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    height: 1.25,
  );
  static TextStyle formTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Multi',
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
    height: 1.25,
  );
  static TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Multi',
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    height: 1.9,
  );
  static TextStyle whiteH6TextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Multi',
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.2,
  );
  static TextStyle hintTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Multi',
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
    height: 1.25,
  );
}
