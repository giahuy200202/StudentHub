import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../../providers/options_provider.dart';

class Archieved extends ConsumerStatefulWidget {
  const Archieved({super.key});

  @override
  ConsumerState<Archieved> createState() {
    return _ArchievedState();
  }
}

class _ArchievedState extends ConsumerState<Archieved> {
  @override
  Widget build(BuildContext context) {
    return const Text('Archieved');
  }
}
