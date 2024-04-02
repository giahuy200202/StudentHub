import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentInput {
  int? techStackId;
  List<int>? skillSets;
  List<dynamic>? languages;
  List<dynamic>? educations;

  StudentInput({
    this.techStackId,
    this.skillSets,
    this.languages,
    this.educations,
  });
}

class StudentInputNotifier extends StateNotifier<StudentInput> {
  StudentInputNotifier()
      : super(StudentInput(
            techStackId: 0, skillSets: [], languages: [], educations: []));

  void setStudentInputData(
    int techStackId,
    List<int> skillSets,
    List<dynamic> languages,
    List<dynamic> educations,
  ) {
    StudentInput temp = StudentInput(
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.techStackId = techStackId;
    temp.skillSets = [...skillSets];
    temp.languages = [...languages];
    temp.educations = [...educations];

    state = temp;
  }
}

final StudentInputProvider =
    StateNotifierProvider<StudentInputNotifier, StudentInput>(
        (ref) => StudentInputNotifier());
