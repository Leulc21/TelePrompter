import 'package:flutter/material.dart';

import '../../services/overlay_service.dart';
import '../../services/prompter_settings.dart';
import '../../theme/nb_tokens.dart';
import 'widgets/background_shapes.dart';
import 'widgets/footer_hint.dart';
import 'widgets/home_title.dart';
import 'widgets/mirror_card.dart';
import 'widgets/overlay_button.dart';
import 'widgets/script_input.dart';
import 'widgets/settings_row.dart';
import 'widgets/top_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _text = TextEditingController();
  double _speed = 60;
  double _fontSize = 32;
  bool _mirror = false;
  bool _overlayOn = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final s = await PrompterSettings.load();
    setState(() {
      _text.text = s.text;
      _speed = s.speed;
      _fontSize = s.fontSize;
    });
    _overlayOn = await OverlayService.isActive();
    if (mounted) setState(() {});
  }

  Future<void> _persist() => PrompterSettings(
    text: _text.text,
    speed: _speed,
    fontSize: _fontSize,
    mirror: _mirror,
  ).save();

  Map<String, dynamic> get _payload => PrompterSettings(
    text: _text.text,
    speed: _speed,
    fontSize: _fontSize,
    mirror: _mirror,
  ).toPayload();

  Future<void> _pushToOverlay() async {
    await _persist();
    await OverlayService.pushData(_payload);
  }

  Future<void> _showOverlay() async {
    if (_text.text.trim().isEmpty) {
      _showSnack('Paste your script first.');
      return;
    }

    if (!await OverlayService.ensurePermission()) return;

    await _persist();
    await OverlayService.show(context: context, payload: _payload);

    if (mounted) setState(() => _overlayOn = true);
  }

  Future<void> _closeOverlay() async {
    await OverlayService.close();
    if (mounted) setState(() => _overlayOn = false);
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: NB.ink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: NB.ink, width: NB.border),
        ),
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundShapes(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final scriptMin = 180.0;
                  final scriptMax = (constraints.maxHeight * 0.45)
                      .clamp(scriptMin, 320.0)
                      .toDouble();

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopBar(overlayOn: _overlayOn),
                        const SizedBox(height: 22),
                        const HomeTitle(),
                        const SizedBox(height: 18),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: scriptMin,
                            maxHeight: scriptMax,
                          ),
                          child: ScriptInput(
                            controller: _text,
                            onChanged: (_) => _persist(),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 2),
                          child: Text('Settings', style: NB.heading),
                        ),
                        SettingsRow(
                          speed: _speed,
                          fontSize: _fontSize,
                          onSpeedChanged: (v) => setState(() => _speed = v),
                          onFontSizeChanged: (v) =>
                              setState(() => _fontSize = v),
                          onCommit: (_) => _pushToOverlay(),
                        ),
                        const SizedBox(height: 6),
                        MirrorCard(
                          value: _mirror,
                          onChanged: (v) {
                            setState(() => _mirror = v);
                            _pushToOverlay();
                          },
                        ),
                        const SizedBox(height: 18),
                        OverlayButton(
                          overlayOn: _overlayOn,
                          onTap: _overlayOn ? _closeOverlay : _showOverlay,
                        ),
                        const SizedBox(height: 12),
                        const FooterHint(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
