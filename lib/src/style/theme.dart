import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

final themeData = ThemeData(
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    headlineMedium: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    headlineSmall: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    titleLarge: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    titleMedium: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    titleSmall: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    bodyLarge: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    bodyMedium: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    bodySmall: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    displayLarge: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    displayMedium: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    displaySmall: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    labelLarge: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    labelMedium: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
    labelSmall: GoogleFonts.pressStart2p().copyWith(color: Palette.one),
  ),
  colorScheme: ColorScheme(
    primary: Palette.one,
    onPrimary: Palette.zero,
    surface: Palette.zero,
    onSurface: Palette.one,
    background: Palette.zero,
    onBackground: Palette.one,
    secondary: Palette.one,
    onSecondary: Palette.zero,
    error: Palette.one,
    onError: Palette.zero,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Palette.zero,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Palette.one,
      onPrimary: Palette.zero,
      textStyle: GoogleFonts.pressStart2p().copyWith(
        color: Colors.black,
      ),
    ),
  ),
);
