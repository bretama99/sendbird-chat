import 'package:flutter/material.dart';

import 'custom_theme.dart/app_bar_theme.dart';
import 'custom_theme.dart/bottom_sheet_theme.dart';
import 'custom_theme.dart/check_box_theme.dart';
import 'custom_theme.dart/chip_theme.dart';
import 'custom_theme.dart/elevated_btn_theme.dart';
import 'custom_theme.dart/text_theme.dart';
import 'custom_theme.dart/textfield_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightThem = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.orange,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: AppTextTheme.lightTextTheme,
      appBarTheme: AppBarThemeCustom.lightAppBarTheme,
      bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheet,
      checkboxTheme: CustomCheckBoxTheme.lightCheckboxThemeData,
      chipTheme: CustomChipTheme.lightChipThemeData,
      elevatedButtonTheme: ElevatedBtnCustomTheme.lightElevatedButtonTheme,
      inputDecorationTheme: AppTextFieldTheme.lightInputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      iconTheme: const IconThemeData(color: Colors.white),
      brightness: Brightness.dark,
      primaryColor: Colors.orangeAccent,
      scaffoldBackgroundColor: const Color(0xFF0e0d0d),
      textTheme: AppTextTheme.darkTextTheme,
      appBarTheme: AppBarThemeCustom.darkAppBarTheme,
      bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheet,
      checkboxTheme: CustomCheckBoxTheme.darkCheckboxThemeData,
      chipTheme: CustomChipTheme.darkChipThemeData,
      elevatedButtonTheme: ElevatedBtnCustomTheme.darkElevatedButtonTheme,
      inputDecorationTheme: AppTextFieldTheme.darkInputDecorationTheme);
}
