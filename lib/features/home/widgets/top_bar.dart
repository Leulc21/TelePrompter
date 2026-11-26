import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';
import '../../../widgets/brutal_box.dart';

class TopBar extends StatelessWidget {
  final bool overlayOn;

  const TopBar({super.key, required this.overlayOn});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BrutalBox(
          radius: 10,
          offset: 4,
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.subtitles, size: 22),
        ),
        const Spacer(),
        BrutalBox(
          radius: 10,
          offset: 4,
          color: overlayOn ? NB.green : NB.paper,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            overlayOn ? 'Overlay on' : 'Overlay off',
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
