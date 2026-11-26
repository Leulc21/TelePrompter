import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';
import '../../../widgets/brutal_box.dart';

class ScriptInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ScriptInput({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BrutalBox(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: TextField(
        controller: controller,
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
        onChanged: onChanged,
      ),
    );
  }
}
