import 'package:flutter/material.dart';

import '../theme/nb_tokens.dart';

class _BrutalThumb extends SliderComponentShape {
  const _BrutalThumb();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(26, 26);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final rect = Rect.fromCenter(center: center, width: 22, height: 22);
    final r = RRect.fromRectAndRadius(rect, const Radius.circular(6));
    canvas.drawRRect(r.shift(const Offset(3, 3)), Paint()..color = NB.ink);
    canvas.drawRRect(r, Paint()..color = sliderTheme.thumbColor ?? NB.yellow);
    canvas.drawRRect(
      r,
      Paint()
        ..color = NB.ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = NB.border,
    );
  }
}

class BrutalSlider extends StatelessWidget {
  final double value, min, max;
  final Color color;
  final ValueChanged<double> onChanged;
  final ValueChanged<double>? onChangeEnd;

  const BrutalSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.color,
    required this.onChanged,
    this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 8,
        activeTrackColor: NB.ink,
        inactiveTrackColor: NB.ink.withOpacity(0.15),
        thumbColor: color,
        overlayColor: Colors.transparent,
        trackShape: const RoundedRectSliderTrackShape(),
        thumbShape: const _BrutalThumb(),
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
        onChangeEnd: onChangeEnd,
      ),
    );
  }
}
