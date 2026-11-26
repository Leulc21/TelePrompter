import 'package:flutter/material.dart';

import '../theme/nb_tokens.dart';

/// A box with a thick black outline and a hard (un-blurred) offset shadow.
class BrutalBox extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;
  final double offset;
  final EdgeInsetsGeometry padding;

  const BrutalBox({
    super.key,
    required this.child,
    this.color = NB.paper,
    this.radius = 14,
    this.offset = 5,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: NB.ink, width: NB.border),
        boxShadow: [
          BoxShadow(
            color: NB.ink,
            offset: Offset(offset, offset),
            blurRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
