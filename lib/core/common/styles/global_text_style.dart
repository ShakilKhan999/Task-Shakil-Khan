import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized text style factory using Google Fonts Inter.
TextStyle getTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required Color color,
  double? lineHeight,
  TextDecoration? decoration,
}) {
  return GoogleFonts.inter(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    height: lineHeight != null ? lineHeight / fontSize : null,
    decoration: decoration,
  );
}
