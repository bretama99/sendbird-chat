import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();
  static TextTheme lightTextTheme = TextTheme(
    //
    headlineLarge: const TextStyle().copyWith(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
    headlineMedium: const TextStyle().copyWith(
        fontWeight: FontWeight.w600, color: Colors.black, fontSize: 24),
    headlineSmall: const TextStyle().copyWith(
        fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16),

    //
    titleLarge: const TextStyle().copyWith(
        fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16),
    titleMedium: const TextStyle().copyWith(
        fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
    titleSmall: const TextStyle().copyWith(
        fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),

    // /
    bodyLarge: const TextStyle().copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFF0e0d0d),
        fontSize: 14),
    bodyMedium: const TextStyle().copyWith(
        fontWeight: FontWeight.normal,
        color: const Color(0xFF0e0d0d),
        fontSize: 14),
    bodySmall: const TextStyle().copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFF0e0d0d).withOpacity(0.5),
        fontSize: 14),

    // /
    labelLarge: const TextStyle().copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFF0e0d0d),
        fontSize: 12),
    labelMedium: const TextStyle().copyWith(
        fontWeight: FontWeight.normal,
        color: const Color(0xFF0e0d0d).withOpacity(0.5),
        fontSize: 12),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontWeight: FontWeight.bold,
        color: const Color(0xFFf1f1f1),
        fontSize: 30),
    headlineMedium: const TextStyle().copyWith(
        fontWeight: FontWeight.w600,
        color: const Color(0xFFf1f1f1),
        fontSize: 24),

    //
    titleLarge: const TextStyle().copyWith(
        fontWeight: FontWeight.w600,
        color: const Color(0xFFf1f1f1),
        fontSize: 16),
    titleMedium: const TextStyle().copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFFf1f1f1),
        fontSize: 16),
    titleSmall: const TextStyle().copyWith(
        fontWeight: FontWeight.w400,
        color: const Color(0xFFf1f1f1),
        fontSize: 16),

    // /
    bodyLarge: const TextStyle().copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFFf1f1f1),
        fontSize: 14),
    bodyMedium: const TextStyle().copyWith(
        fontWeight: FontWeight.normal,
        color: const Color(0xFFf1f1f1),
        fontSize: 14),
    bodySmall: const TextStyle().copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFFf1f1f1).withOpacity(0.5),
        fontSize: 14),

    // /

    labelLarge: const TextStyle().copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFFf1f1f1),
        fontSize: 12),
    labelMedium: const TextStyle().copyWith(
        fontWeight: FontWeight.normal,
        color: const Color(0xFFf1f1f1).withOpacity(0.5),
        fontSize: 12),

    //
  );
}
