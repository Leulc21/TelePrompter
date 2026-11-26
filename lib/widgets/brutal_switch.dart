import 'package:flutter/material.dart';

import '../theme/nb_tokens.dart';

class BrutalSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  const BrutalSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = NB.green,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: 56,
        height: 30,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: value ? activeColor : NB.paper,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: NB.ink, width: NB.border),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 120),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            decoration: BoxDecoration(
              color: NB.ink,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
