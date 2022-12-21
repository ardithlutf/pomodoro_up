import 'package:flutter/material.dart';

abstract class PomodoroUpWidgets {
  static const titleStyle =
      TextStyle(fontSize: 29.0, fontWeight: FontWeight.w400);

  static const titleStyleWhite = TextStyle(
      fontSize: 23.0, fontWeight: FontWeight.w400, color: Colors.white);

  static const titleStyleOrange = TextStyle(
      fontSize: 23.0,
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(255, 195, 137, 1));

  static const titleCardStyle = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w400, color: Colors.white);

  static const subtitleCardStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.white);

  static const subtitle2CardStyle = TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.white);
}
