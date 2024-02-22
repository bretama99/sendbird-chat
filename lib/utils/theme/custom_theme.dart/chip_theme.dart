import 'package:flutter/material.dart';

class CustomChipTheme {
  CustomChipTheme._();
  static ChipThemeData lightChipThemeData = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(
      color: Colors.black,
    ),
    selectedColor: Colors.blue,
  );

  static ChipThemeData darkChipThemeData = const ChipThemeData(
    disabledColor: Colors.grey,
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    selectedColor: Colors.blue,
  );
}
