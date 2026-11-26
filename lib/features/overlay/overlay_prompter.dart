import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

import 'widgets/overlay_frame.dart';

class OverlayPrompter extends StatefulWidget {
  const OverlayPrompter({super.key});

  @override
  State<OverlayPrompter> createState() => _OverlayPrompterState();
}

class _OverlayPrompterState extends State<OverlayPrompter>
    with SingleTickerProviderStateMixin {
  final _scroll = ScrollController();
  late final Ticker _ticker;
  StreamSubscription? _sub;
  Duration _last = Duration.zero;

  String _text = 'Waiting for script...';
  double _speed = 60;
  double _fontSize = 32;
  bool _mirror = false;
  bool _playing = false;

  static const double _readLineTop = 84;

  @override
  void initState() {
    super.initState();

    // ─────────────────────────────────────────────────────────────
    // If you do NOT see this line in the terminal after tapping
    // "Show overlay", then `overlayMain` was never reached — most
    // likely because `lib/main.dart` does not import
    // `lib/overlay_main.dart`. See the fix in the previous message.
    // ─────────────────────────────────────────────────────────────
    debugPrint('>>> OverlayPrompter.initState: overlayMain IS RUNNING');

    _ticker = createTicker(_onTick)..start();

    _sub = FlutterOverlayWindow.overlayListener.listen((data) {
      debugPrint('>>> OverlayPrompter received data: $data');
      if (data is Map) {
        setState(() {
          _text = (data['text'] as String?) ?? _text;
          _speed = (data['speed'] as num?)?.toDouble() ?? _speed;
          _fontSize = (data['fontSize'] as num?)?.toDouble() ?? _fontSize;
          _mirror = (data['mirror'] as bool?) ?? _mirror;
        });
        debugPrint(
          '>>> OverlayPrompter applied: '
          'textLen=${_text.length}, speed=$_speed, '
          'fontSize=$_fontSize, mirror=$_mirror',
        );
      }
    });
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;
    if (!_playing || !_scroll.hasClients) return;

    final max = _scroll.position.maxScrollExtent;
    final next = _scroll.offset + _speed * dt;
    if (next >= max) {
      _scroll.jumpTo(max);
      setState(() => _playing = false);
    } else {
      _scroll.jumpTo(next);
    }
  }

  void _restart() {
    if (_scroll.hasClients) _scroll.jumpTo(0);
    setState(() => _playing = false);
  }

  @override
  void dispose() {
    debugPrint('>>> OverlayPrompter.dispose');
    _sub?.cancel();
    _ticker.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayFrame(
      scrollController: _scroll,
      text: _text,
      fontSize: _fontSize,
      mirror: _mirror,
      readLineTop: _readLineTop,
      playing: _playing,
      onTogglePlay: () => setState(() => _playing = !_playing),
      onRestart: _restart,
      onSpeedDown: () => setState(() => _speed = (_speed - 10).clamp(10, 300)),
      onSpeedUp: () => setState(() => _speed = (_speed + 10).clamp(10, 300)),
      onClose: () => FlutterOverlayWindow.closeOverlay(),
    );
  }
}
