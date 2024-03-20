import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../../providers/options_provider.dart';

class ArchievedWidget extends ConsumerStatefulWidget {
  const ArchievedWidget({super.key});

  @override
  ConsumerState<ArchievedWidget> createState() {
    return _ArchievedWidgetState();
  }
}

class _ArchievedWidgetState extends ConsumerState<ArchievedWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text('Archieved');
  }
}
