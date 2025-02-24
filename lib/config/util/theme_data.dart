import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xff1DA1F2),
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Color(0xff1DA1F2),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
  );
}
