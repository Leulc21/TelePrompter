import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';
import '../../../widgets/brutal_button.dart';

/// The yellow bar at the top of the overlay with all the controls.
class OverlayControlBar extends StatelessWidget {
  final bool playing;
  final VoidCallback onTogglePlay;
  final VoidCallback onRestart;
  final VoidCallback onSpeedDown;
  final VoidCallback onSpeedUp;
  final VoidCallback onClose;

  static const double _height = 64;

  const OverlayControlBar({
    super.key,
    required this.playing,
    required this.onTogglePlay,
    required this.onRestart,
    required this.onSpeedDown,
    required this.onSpeedUp,
    required this.onClose,
  });

  Widget _iconBtn(IconData icon, VoidCallback onTap, {Color color = NB.paper}) {
    return BrutalButton(
      onTap: onTap,
      color: color,
      radius: 10,
      offset: 3,
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: NB.ink, size: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: NB.yellow,
        border: Border(
          bottom: BorderSide(color: NB.ink, width: NB.border),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconBtn(Icons.replay, onRestart),
          _iconBtn(Icons.remove, onSpeedDown),
          BrutalButton(
            onTap: onTogglePlay,
            color: playing ? NB.orange : NB.green,
            radius: 10,
            offset: 3,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  playing ? Icons.pause : Icons.play_arrow,
                  color: NB.ink,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  playing ? 'Pause' : 'Start',
                  style: const TextStyle(
                    color: NB.ink,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          _iconBtn(Icons.add, onSpeedUp),
          _iconBtn(Icons.close, onClose, color: NB.pink),
        ],
      ),
    );
  }
}
