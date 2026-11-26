import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';
import '../../../widgets/brutal_switch.dart';
import '../../../widgets/folder_card.dart';
import '../../../widgets/icon_chip.dart';

class MirrorCard extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const MirrorCard({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FolderCard(
      tabColor: NB.purple,
      child: Row(
        children: [
          const IconChip(icon: Icons.flip, color: NB.purple, size: 38),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mirror text', style: NB.heading),
                Text('For beam-splitter glass', style: NB.small),
              ],
            ),
          ),
          BrutalSwitch(
            value: value,
            activeColor: NB.purple,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
