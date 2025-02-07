import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Color(0xff1DA1F2),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
  );
}
