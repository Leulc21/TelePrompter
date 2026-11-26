import 'package:flutter/material.dart';

import '../theme/nb_tokens.dart';

/// Small square icon chip with a border.
class IconChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const IconChip({
    super.key,
    required this.icon,
    required this.color,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: NB.ink, width: NB.border),
      ),
      child: Icon(icon, color: NB.ink, size: size * 0.55),
    );
  }
}
