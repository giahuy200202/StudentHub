import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/options_provider.dart';

class Working extends ConsumerStatefulWidget {
  const Working({super.key});

  @override
  ConsumerState<Working> createState() {
    return _WorkingState();
  }
}

class _WorkingState extends ConsumerState<Working> {
  @override
  Widget build(BuildContext context) {
    return const Text('Working');
  }
}
