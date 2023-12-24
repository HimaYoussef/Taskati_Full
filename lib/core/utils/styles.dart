import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTitleStyle(
    {Color color = Colors.black,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.bold}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
}

TextStyle getBodyStyle(
    {Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w500}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
}

TextStyle getSmallStyle(
    {Color color = Colors.grey,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
}
