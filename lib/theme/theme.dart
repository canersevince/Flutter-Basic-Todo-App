import 'package:flutter/material.dart';

//maintheme
ThemeData MainTheme() {
  return ThemeData(
    primarySwatch: Colors.pink,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      headline1: TitleTheme(),
      headline2: TitleTheme(),
      headline3: Title3Theme(),
      headline4: TitleTheme(),
      headline5: TitleTheme(),
      headline6: TitleTheme(),
    ),
    primaryTextTheme: TextTheme(bodyText1: ContentTextTheme()),
  );
}

//title styles
TextStyle TitleTheme() {
  return TextStyle(
      fontSize: 18,
      fontFamily: "Quicksand",
      fontWeight: FontWeight.bold,
      color: Colors.white);
}

TextStyle Title3Theme() {
  return TextStyle(
    letterSpacing: 1,
    fontSize: 16,
    fontFamily: "OpenSans",
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
}

TextStyle ContentTextTheme() {
  return TextStyle(fontSize: 18, fontFamily: "OpenSans", color: Colors.black);
}

//end
