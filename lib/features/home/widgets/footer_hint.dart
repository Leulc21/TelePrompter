import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';

class FooterHint extends StatelessWidget {
  const FooterHint({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Then open your camera app. Tap Start on the floating '
        'prompter when you begin recording.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: NB.ink,
        ),
      ),
    );
  }
}
