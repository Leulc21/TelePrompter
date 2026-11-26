import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';

class BackgroundShapes extends StatelessWidget {
  const BackgroundShapes({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -120,
          top: 90,
          child: Container(
            width: 260,
            height: 260,
            decoration: const BoxDecoration(
              color: NB.pink,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: -60,
          bottom: -40,
          child: Transform.rotate(
            angle: -0.35,
            child: Container(width: 280, height: 320, color: NB.purple),
          ),
        ),
      ],
    );
  }
}
