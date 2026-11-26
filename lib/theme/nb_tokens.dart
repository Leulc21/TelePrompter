import 'package:flutter/material.dart';

/// Neo-brutalist design tokens.
class NB {
  static const ink = Color(0xFF000000);
  static const paper = Color(0xFFFBF8F3);
  static const yellow = Color(0xFFFFCF1F);
  static const pink = Color(0xFFFF4F81);
  static const purple = Color(0xFF7B61FF);
  static const green = Color(0xFF3DC13C);
  static const lime = Color(0xFFA6D61F);
  static const peach = Color(0xFFFFDD8A);
  static const orange = Color(0xFFFF9F1C);

  static const border = 2.5;

  static const title = TextStyle(
    color: ink,
    fontSize: 40,
    height: 1.05,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.2,
  );
  static const heading = TextStyle(
    color: ink,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  static const small = TextStyle(
    color: Color(0xFF444444),
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}
