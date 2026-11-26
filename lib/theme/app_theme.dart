import 'package:flutter/material.dart';

import 'nb_tokens.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: NB.yellow,
    scaffoldBackgroundColor: NB.yellow,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: NB.ink,
      selectionColor: NB.peach,
      selectionHandleColor: NB.ink,
    ),
  );
}
