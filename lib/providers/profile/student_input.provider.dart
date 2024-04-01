import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentInput {
  List<int>? skillSets;

  StudentInput({
    this.skillSets,
  });
}

class StudentInputNotifier extends StateNotifier<StudentInput> {
  StudentInputNotifier() : super(StudentInput(skillSets: []));

  void setStudentInputData(List<int> skillSets) {
    StudentInput temp = StudentInput(
      skillSets: [...state.skillSets!],
    );

    temp.skillSets = [...skillSets];
    state = temp;
  }
}

final StudentInputProvider =
    StateNotifierProvider<StudentInputNotifier, StudentInput>(
        (ref) => StudentInputNotifier());
