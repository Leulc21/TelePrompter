import 'package:flutter/material.dart';

import 'features/overlay/overlay_prompter.dart';

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
