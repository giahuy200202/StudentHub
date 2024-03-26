import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studenthub/widgets/projects/project_search.widget.dart';

class ProjectSearchScreen extends ConsumerWidget {
  const ProjectSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ProjectSearchWidget();
  }
}
