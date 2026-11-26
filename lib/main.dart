import 'package:flutter/material.dart';

import 'features/home/home_page.dart';
import 'features/overlay/overlay_prompter.dart';
import 'theme/app_theme.dart';

void main() => runApp(const TeleprompterApp());


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

class TeleprompterApp extends StatelessWidget {
  const TeleprompterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teleprompter',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomePage(),
    );
  }
}
