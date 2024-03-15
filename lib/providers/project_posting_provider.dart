import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectPosting {
  String? title;
  int? scope;
  String? numOfStudents;
  String? description;

  ProjectPosting({
    this.title,
    this.scope,
    this.numOfStudents,
    this.description,
  });
}

class ProjectPostingNotifier extends StateNotifier<ProjectPosting> {
  ProjectPostingNotifier()
      : super(ProjectPosting(
          title: '',
          scope: 1,
          numOfStudents: '',
          description: '',
        ));

  void setTitle(String value) {
    ProjectPosting temp = ProjectPosting(
      title: state.title,
      scope: state.scope,
      numOfStudents: state.numOfStudents,
      description: state.description,
    );
    temp.title = value;
    state = temp;
  }

  void setScope(int value) {
    ProjectPosting temp = ProjectPosting(
      title: state.title,
      scope: state.scope,
      numOfStudents: state.numOfStudents,
      description: state.description,
    );
    temp.scope = value;
    state = temp;
  }

  void setNumOfStudents(String value) {
    ProjectPosting temp = ProjectPosting(
      title: state.title,
      scope: state.scope,
      numOfStudents: state.numOfStudents,
      description: state.description,
    );
    temp.numOfStudents = value;
    state = temp;
  }

  void setDescription(String value) {
    ProjectPosting temp = ProjectPosting(
      title: state.title,
      scope: state.scope,
      numOfStudents: state.numOfStudents,
      description: state.description,
    );
    temp.description = value;
    state = temp;
  }
}

final projectPostingProvider =
    StateNotifierProvider<ProjectPostingNotifier, ProjectPosting>(
        (ref) => ProjectPostingNotifier());
