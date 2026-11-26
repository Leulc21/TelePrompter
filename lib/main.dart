import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ---------------------------------------------------------------------------
// Neo-brutalist design tokens
// ---------------------------------------------------------------------------

class NB {
  static const ink = Color(0xFF000000);
  static const paper = Color(0xFFFBF8F3);
  static const yellow = Color(0xFFFFCF1F);
  static const pink = Color(0xFFFF4F81);
  static const purple = Color(0xFF7B61FF);
  static const green = Color(0xFF3DC13C);
  static const lime = Color(0xFFA6D61F);
  static const peach = Color(0xFFFFDD8A);
  static const orange = Color(0xFFFF9F1C);

  static const border = 2.5;

  static const title = TextStyle(
    color: ink,
    fontSize: 40,
    height: 1.05,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.2,
  );
  static const heading = TextStyle(
    color: ink,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  static const small = TextStyle(
    color: Color(0xFF444444),
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
}

// ---------------------------------------------------------------------------
// Reusable neo-brutalist widgets
// ---------------------------------------------------------------------------

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

/// Small square icon chip with a border (like the icons on the folder cards).
class IconChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const IconChip({
    super.key,
    required this.icon,
    required this.color,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: NB.ink, width: NB.border),
      ),
      child: Icon(icon, color: NB.ink, size: size * 0.55),
    );
  }
}

/// Card with a coloured folder tab sticking out of the top-left corner.
class FolderCard extends StatelessWidget {
  final Color tabColor;
  final Widget child;

  const FolderCard({super.key, required this.tabColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -14,
            left: 12,
            child: Container(
              width: 52,
              height: 20,
              decoration: BoxDecoration(
                color: tabColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8),
                ),
                border: Border.all(color: NB.ink, width: NB.border),
              ),
            ),
          ),
          BrutalBox(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: child,
          ),
        ],
      ),
    );
  }
}

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

// ---------------------------------------------------------------------------
// Entry points
// ---------------------------------------------------------------------------

void main() => runApp(const TeleprompterApp());

/// Entry point for the floating overlay window (runs in its own Flutter engine).
/// The name must match what flutter_overlay_window looks for: "overlayMain".
@pragma('vm:entry-point')
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverlayPrompter(),
    ),
  );
}

// ---------------------------------------------------------------------------
// Main app: paste script + start the overlay
// ---------------------------------------------------------------------------

class TeleprompterApp extends StatelessWidget {
  const TeleprompterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teleprompter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: NB.yellow,
        scaffoldBackgroundColor: NB.yellow,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: NB.ink,
          selectionColor: NB.peach,
          selectionHandleColor: NB.ink,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _text = TextEditingController();
  double _speed = 60; // pixels per second
  double _fontSize = 32;
  bool _mirror = false;
  bool _overlayOn = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      _text.text = p.getString('script') ?? '';
      _speed = p.getDouble('speed') ?? 60;
      _fontSize = p.getDouble('fontSize') ?? 32;
    });
    _overlayOn = await FlutterOverlayWindow.isActive();
    if (mounted) setState(() {});
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString('script', _text.text);
    await p.setDouble('speed', _speed);
    await p.setDouble('fontSize', _fontSize);
  }

  Map<String, dynamic> get _payload => {
    'text': _text.text,
    'speed': _speed,
    'fontSize': _fontSize,
    'mirror': _mirror,
  };

  Future<void> _pushToOverlay() async {
    await _save();
    if (await FlutterOverlayWindow.isActive()) {
      await FlutterOverlayWindow.shareData(_payload);
    }
  }

  Future<void> _showOverlay() async {
    if (_text.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: NB.ink,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: NB.ink, width: NB.border),
          ),
          content: const Text(
            'Paste your script first.',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      );
      return;
    }

    // "Display over other apps" permission (user grants once in Settings).
    var granted = await FlutterOverlayWindow.isPermissionGranted();
    if (!granted) {
      granted = await FlutterOverlayWindow.requestPermission() ?? false;
      if (!granted) return;
    }

    await _save();

    if (await FlutterOverlayWindow.isActive()) {
      await FlutterOverlayWindow.closeOverlay();
    }

    final mq = MediaQuery.of(context);
    // Overlay size is in physical pixels: ~45% of the screen height, full width.
    final heightPx = (mq.size.height * 0.45 * mq.devicePixelRatio).round();

    await FlutterOverlayWindow.showOverlay(
      height: heightPx,
      width: WindowSize.matchParent,
      alignment: OverlayAlignment.topCenter,
      enableDrag: true,
      overlayTitle: 'Teleprompter',
      overlayContent: 'Teleprompter is running',
      flag: OverlayFlag.defaultFlag,
      visibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.none,
    );

    // Give the overlay engine a moment to start listening, then send the script.
    await Future.delayed(const Duration(milliseconds: 600));
    await FlutterOverlayWindow.shareData(_payload);

    if (mounted) setState(() => _overlayOn = true);
  }

  Future<void> _closeOverlay() async {
    await FlutterOverlayWindow.closeOverlay();
    if (mounted) setState(() => _overlayOn = false);
  }

  @override
  Widget build(BuildContext context) {
    // True while the on-screen keyboard is showing.
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            // Background shapes, like the concept's pink circle + purple block.
            Positioned(
              left: -120,
              top: 90,
              child: Container(
                width: 260,
                height: 260,
                decoration: const BoxDecoration(
                  color: NB.pink,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: -60,
              bottom: -40,
              child: Transform.rotate(
                angle: -0.35,
                child: Container(width: 280, height: 320, color: NB.purple),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top bar
                    Row(
                      children: [
                        BrutalBox(
                          radius: 10,
                          offset: 4,
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.subtitles, size: 22),
                        ),
                        const Spacer(),
                        BrutalBox(
                          radius: 10,
                          offset: 4,
                          color: _overlayOn ? NB.green : NB.paper,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Text(
                            _overlayOn ? 'Overlay on' : 'Overlay off',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: keyboardOpen ? 10 : 22),

                    // Title (hidden while typing)
                    if (!keyboardOpen) ...[
                      const Text(
                        'Write once.\nRead anywhere.',
                        style: NB.title,
                      ),
                      const SizedBox(height: 18),
                    ],

                    // Script input (always visible, takes all remaining space)
                    Expanded(
                      child: BrutalBox(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        child: TextField(
                          controller: _text,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: NB.ink,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Paste or type what you want to say...',
                            hintStyle: TextStyle(
                              color: Color(0xFF777777),
                              fontWeight: FontWeight.w600,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          onChanged: (_) => _save(),
                        ),
                      ),
                    ),

                    // Everything below is hidden while typing
                    if (!keyboardOpen) ...[
                      const SizedBox(height: 6),

                      const Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 2),
                        child: Text('Settings', style: NB.heading),
                      ),

                      // Speed + Font size folder cards
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: FolderCard(
                              tabColor: NB.green,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const IconChip(
                                        icon: Icons.bolt,
                                        color: NB.green,
                                        size: 38,
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${_speed.round()} px/s',
                                        style: NB.small,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text('Speed', style: NB.heading),
                                  BrutalSlider(
                                    value: _speed,
                                    min: 10,
                                    max: 200,
                                    color: NB.green,
                                    onChanged: (v) =>
                                        setState(() => _speed = v),
                                    onChangeEnd: (_) => _pushToOverlay(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: FolderCard(
                              tabColor: NB.pink,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const IconChip(
                                        icon: Icons.format_size,
                                        color: NB.pink,
                                        size: 38,
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${_fontSize.round()} pt',
                                        style: NB.small,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text('Font size', style: NB.heading),
                                  BrutalSlider(
                                    value: _fontSize,
                                    min: 18,
                                    max: 72,
                                    color: NB.pink,
                                    onChanged: (v) =>
                                        setState(() => _fontSize = v),
                                    onChangeEnd: (_) => _pushToOverlay(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Mirror toggle card
                      FolderCard(
                        tabColor: NB.purple,
                        child: Row(
                          children: [
                            const IconChip(
                              icon: Icons.flip,
                              color: NB.purple,
                              size: 38,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Mirror text', style: NB.heading),
                                  Text(
                                    'For beam-splitter glass',
                                    style: NB.small,
                                  ),
                                ],
                              ),
                            ),
                            BrutalSwitch(
                              value: _mirror,
                              activeColor: NB.purple,
                              onChanged: (v) {
                                setState(() => _mirror = v);
                                _pushToOverlay();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Main action
                      SizedBox(
                        width: double.infinity,
                        child: BrutalButton(
                          color: _overlayOn ? NB.pink : NB.yellow,
                          offset: 6,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          onTap: _overlayOn ? _closeOverlay : _showOverlay,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _overlayOn ? Icons.close : Icons.add,
                                size: 26,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _overlayOn ? 'Close overlay' : 'Show overlay',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: NB.ink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Center(
                        child: Text(
                          'Then open your camera app. Tap Start on the floating '
                          'prompter when you begin recording.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: NB.ink,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Overlay: floating, draggable, scrolling text with Start/Pause
// ---------------------------------------------------------------------------

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

  static const double _barHeight = 64;
  static const double _readLineTop = 84;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
    _sub = FlutterOverlayWindow.overlayListener.listen((data) {
      if (data is Map) {
        setState(() {
          _text = (data['text'] as String?) ?? _text;
          _speed = (data['speed'] as num?)?.toDouble() ?? _speed;
          _fontSize = (data['fontSize'] as num?)?.toDouble() ?? _fontSize;
          _mirror = (data['mirror'] as bool?) ?? _mirror;
        });
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
      setState(() => _playing = false); // reached the end
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
    _sub?.cancel();
    _ticker.dispose();
    _scroll.dispose();
    super.dispose();
  }

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
    Widget textView = ListView(
      controller: _scroll,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, _readLineTop - 14, 16, 400),
      children: [
        Text(
          _text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: _fontSize,
            height: 1.4,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
    if (_mirror) {
      textView = Transform(
        alignment: Alignment.center,
        transform: Matrix4.diagonal3Values(-1, 1, 1),
        child: textView,
      );
    }

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
                Positioned.fill(child: textView),

                // Reading line near the top (closest to the camera lens).
                Positioned(
                  top: _readLineTop,
                  left: 0,
                  right: 0,
                  child: Container(height: 4, color: NB.pink),
                ),

                // Control bar (stays above the text).
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: _barHeight,
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
                        _iconBtn(Icons.replay, _restart),
                        _iconBtn(
                          Icons.remove,
                          () => setState(
                            () => _speed = (_speed - 10).clamp(10, 300),
                          ),
                        ),
                        BrutalButton(
                          onTap: () => setState(() => _playing = !_playing),
                          color: _playing ? NB.orange : NB.green,
                          radius: 10,
                          offset: 3,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _playing ? Icons.pause : Icons.play_arrow,
                                color: NB.ink,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _playing ? 'Pause' : 'Start',
                                style: const TextStyle(
                                  color: NB.ink,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _iconBtn(
                          Icons.add,
                          () => setState(
                            () => _speed = (_speed + 10).clamp(10, 300),
                          ),
                        ),
                        _iconBtn(
                          Icons.close,
                          () => FlutterOverlayWindow.closeOverlay(),
                          color: NB.pink,
                        ),
                      ],
                    ),
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
