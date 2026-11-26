import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';
import '../../../widgets/brutal_slider.dart';
import '../../../widgets/folder_card.dart';
import '../../../widgets/icon_chip.dart';

/// One folder card containing an icon chip, a value readout, a label and a
/// slider. Shared by the Speed and Font size cards.
class SliderCard extends StatelessWidget {
  final Color tabColor;
  final IconData chipIcon;
  final String valueText;
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onCommit;

  const SliderCard({
    super.key,
    required this.tabColor,
    required this.chipIcon,
    required this.valueText,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.onCommit,
  });

  @override
  Widget build(BuildContext context) {
    return FolderCard(
      tabColor: tabColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconChip(icon: chipIcon, color: tabColor, size: 38),
              const Spacer(),
              Text(valueText, style: NB.small),
            ],
          ),
          const SizedBox(height: 8),
          Text(label, style: NB.heading),
          BrutalSlider(
            value: value,
            min: min,
            max: max,
            color: tabColor,
            onChanged: onChanged,
            onChangeEnd: onCommit,
          ),
        ],
      ),
    );
  }
}
