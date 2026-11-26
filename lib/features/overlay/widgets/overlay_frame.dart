import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';
import 'overlay_control_bar.dart';
import 'overlay_reading_line.dart';

/// The whole floating overlay: dark rounded box, scrolling text, reading line
/// and control bar. Purely presentational — all state lives in the caller.
class OverlayFrame extends StatelessWidget {
  final ScrollController scrollController;
  final String text;
  final double fontSize;
  final bool mirror;
  final double readLineTop;
  final bool playing;
  final VoidCallback onTogglePlay;
  final VoidCallback onRestart;
  final VoidCallback onSpeedDown;
  final VoidCallback onSpeedUp;
  final VoidCallback onClose;

  const OverlayFrame({
    super.key,
    required this.scrollController,
    required this.text,
    required this.fontSize,
    required this.mirror,
    required this.readLineTop,
    required this.playing,
    required this.onTogglePlay,
    required this.onRestart,
    required this.onSpeedDown,
    required this.onSpeedUp,
    required this.onClose,
  });

  Widget _textView() {
    Widget view = ListView(
      controller: scrollController,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16, readLineTop - 14, 16, 400),
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            height: 1.4,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
    if (mirror) {
      view = Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(-1, 1, 1),
        child: view,
      );
    }
    return view;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        // Room for the hard shadow inside the transparent overlay window.
        padding: const EdgeInsets.only(right: 6, bottom: 6),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: NB.ink, width: NB.border),
            boxShadow: const [
              BoxShadow(color: NB.yellow, offset: Offset(5, 5), blurRadius: 0),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Stack(
              children: [
                Positioned.fill(child: _textView()),
                OverlayReadingLine(top: readLineTop),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: OverlayControlBar(
                    playing: playing,
                    onTogglePlay: onTogglePlay,
                    onRestart: onRestart,
                    onSpeedDown: onSpeedDown,
                    onSpeedUp: onSpeedUp,
                    onClose: onClose,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
