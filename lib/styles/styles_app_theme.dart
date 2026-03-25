import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static const Color pink = Color(0xFFe9636e);
  static const Color backgroundLight = Color(0xFFfffafb);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: pink,
        primary: pink,
        secondary: backgroundLight,
        surface: backgroundLight,
      ),
    );
  }

}
