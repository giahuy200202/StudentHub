import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo/models/option.dart';

class ProjectIdNotifier extends StateNotifier<String> {
  ProjectIdNotifier() : super('');

  bool setProjectId(String projectId) {
    state = projectId;
    return true;
  }
}

final projectIdProvider = StateNotifierProvider<ProjectIdNotifier, String>((ref) {
  return ProjectIdNotifier();
});
