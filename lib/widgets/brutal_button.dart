import 'package:flutter/material.dart';

import '../theme/nb_tokens.dart';

/// Tappable BrutalBox that "presses" into its shadow.
class BrutalButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color color;
  final double radius;
  final double offset;
  final EdgeInsetsGeometry padding;

  const BrutalButton({
    super.key,
    required this.child,
    required this.onTap,
    this.color = NB.yellow,
    this.radius = 14,
    this.offset = 5,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  State<BrutalButton> createState() => _BrutalButtonState();
}

class _BrutalButtonState extends State<BrutalButton> {
  bool _down = false;

  @override
  Widget build(BuildContext context) {
    final o = widget.offset;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _down = true),
      onTapCancel: () => setState(() => _down = false),
      onTapUp: (_) => setState(() => _down = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 70),
        transform: Matrix4.translationValues(_down ? o : 0, _down ? o : 0, 0),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(color: NB.ink, width: NB.border),
          boxShadow: [
            BoxShadow(
              color: NB.ink,
              offset: _down ? Offset.zero : Offset(o, o),
              blurRadius: 0,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
