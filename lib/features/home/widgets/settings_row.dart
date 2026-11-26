import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';
import 'slider_card.dart';

class SettingsRow extends StatelessWidget {
  final double speed;
  final double fontSize;
  final ValueChanged<double> onSpeedChanged;
  final ValueChanged<double> onFontSizeChanged;
  final ValueChanged<double> onCommit;

  const SettingsRow({
    super.key,
    required this.speed,
    required this.fontSize,
    required this.onSpeedChanged,
    required this.onFontSizeChanged,
    required this.onCommit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SliderCard(
            tabColor: NB.green,
            chipIcon: Icons.bolt,
            valueText: '${speed.round()} px/s',
            label: 'Speed',
            value: speed,
            min: 10,
            max: 200,
            onChanged: onSpeedChanged,
            onCommit: onCommit,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SliderCard(
            tabColor: NB.pink,
            chipIcon: Icons.format_size,
            valueText: '${fontSize.round()} pt',
            label: 'Font size',
            value: fontSize,
            min: 18,
            max: 72,
            onChanged: onFontSizeChanged,
            onCommit: onCommit,
          ),
        ),
      ],
    );
  }
}
