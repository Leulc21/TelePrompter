import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';

/// The pink horizontal "read here" line near the top of the overlay.
class OverlayReadingLine extends StatelessWidget {
  final double top;

  const OverlayReadingLine({super.key, required this.top});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Container(height: 4, color: NB.pink),
    );
  }
}
