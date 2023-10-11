import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin AppTypography {
  static const TextStyle headline1 = TextStyle(
    fontFamily: 'SF',
    fontWeight: FontWeight.bold,
    fontSize: 32,
    color: Colors.black,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: 'SF',
    fontWeight: FontWeight.bold,
    fontSize: 30,
    color: Colors.black,
  );

static const TextStyle headline3 = TextStyle(
    fontFamily: 'SF',
    fontWeight: FontWeight.bold,
    fontSize: 30,
    color: Colors.black,
  );

  static final TextStyle headline4 = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.black,
  );

  static const TextStyle title = TextStyle(
    fontFamily: 'SF',
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.black,
  );


  static const TextStyle description = TextStyle(
    fontFamily: 'SF',
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.black,
  );


  static final TextStyle buttonLink = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 13,
    color: Colors.black,
  );

  static final TextStyle textButton = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 17,
    color: Colors.black,
  );

  static final TextStyle caption = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.black,
  );

  static final TextStyle formText = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    fontSize: 17,
    color: Colors.black,
  );
}
