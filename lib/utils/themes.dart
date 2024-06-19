import 'package:beacon_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

final defaultLightTheme = ThemeData(
  useMaterial3: true,
  cardColor: loginCardColor,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  primarySwatch: Colors.green,
  fontFamily: 'Poppins-Medium',
  cardTheme: const CardTheme(color: loginCardColor),
  unselectedWidgetColor: const Color(0xff141414).withOpacity(0.2),
  timePickerTheme: const TimePickerThemeData(hourMinuteColor: Colors.white),
  scaffoldBackgroundColor: loginBgColor,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
  ),
);
