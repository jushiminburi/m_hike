import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin AppTypography {
  static const TextStyle title = TextStyle(fontFamily: 'SF', fontSize: 16);

  static final TextStyle headline1 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.black,
  );

  static final TextStyle headline2 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.black,
  );

  static final TextStyle headline3 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.black,
  );

  static final TextStyle headline4 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.black,
  );
}
