import 'package:shared_preferences/shared_preferences.dart';

/// Immutable snapshot of everything the prompter needs.
class PrompterSettings {
  final String text;
  final double speed;
  final double fontSize;
  final bool mirror;

  const PrompterSettings({
    required this.text,
    required this.speed,
    required this.fontSize,
    required this.mirror,
  });

  Map<String, dynamic> toPayload() => {
    'text': text,
    'speed': speed,
    'fontSize': fontSize,
    'mirror': mirror,
  };

  /// Load from SharedPreferences (script/speed/fontSize are persisted;
  /// mirror is currently in-memory only).
  static Future<PrompterSettings> load() async {
    final p = await SharedPreferences.getInstance();
    return PrompterSettings(
      text: p.getString('script') ?? '',
      speed: p.getDouble('speed') ?? 60,
      fontSize: p.getDouble('fontSize') ?? 32,
      mirror: false,
    );
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString('script', text);
    await p.setDouble('speed', speed);
    await p.setDouble('fontSize', fontSize);
  }
}
