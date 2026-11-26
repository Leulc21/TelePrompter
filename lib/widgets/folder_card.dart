import 'package:flutter/material.dart';

import '../theme/nb_tokens.dart';
import 'brutal_box.dart';

/// Card with a coloured folder tab sticking out of the top-left corner.
class FolderCard extends StatelessWidget {
  final Color tabColor;
  final Widget child;

  const FolderCard({super.key, required this.tabColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -14,
            left: 12,
            child: Container(
              width: 52,
              height: 20,
              decoration: BoxDecoration(
                color: tabColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                border: Border.all(color: NB.ink, width: NB.border),
              ),
            ),
          ),
          BrutalBox(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: child,
          ),
        ],
      ),
    );
  }
}
