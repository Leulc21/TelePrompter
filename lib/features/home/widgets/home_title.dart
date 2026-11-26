import 'package:flutter/material.dart';

import '../../../theme/nb_tokens.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Write once.\nRead anywhere.', style: NB.title);
  }
}
