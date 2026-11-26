import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';
import '../../../widgets/brutal_button.dart';

class OverlayButton extends StatelessWidget {
  final bool overlayOn;
  final VoidCallback onTap;

  const OverlayButton({
    super.key,
    required this.overlayOn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BrutalButton(
        color: overlayOn ? NB.pink : NB.yellow,
        offset: 6,
        padding: const EdgeInsets.symmetric(vertical: 16),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(overlayOn ? Icons.close : Icons.add, size: 26),
            const SizedBox(width: 8),
            Text(
              overlayOn ? 'Close overlay' : 'Show overlay',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: NB.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
