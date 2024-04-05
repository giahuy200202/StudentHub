import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentInput {
  String? fullname;
  int? techStackId;
  List<int>? skillSets;
  List<dynamic>? languages;
  List<dynamic>? educations;

  StudentInput({
    this.fullname,
    this.techStackId,
    this.skillSets,
    this.languages,
    this.educations,
  });
}

class StudentInputNotifier extends StateNotifier<StudentInput> {
  StudentInputNotifier() : super(StudentInput(fullname: '', techStackId: 0, skillSets: [], languages: [], educations: []));

  void setStudentInputData(
    String fullname,
    int techStackId,
    List<int> skillSets,
    List<dynamic> languages,
    List<dynamic> educations,
    responseStudent,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.fullname = fullname;
    temp.techStackId = techStackId;
    temp.skillSets = [...skillSets];
    temp.languages = [...languages];
    temp.educations = [...educations];

    state = temp;
  }

  void setStudentInputFullname(
    String fullname,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.fullname = fullname;

    state = temp;
  }

  void setStudentInputTechstackId(
    int id,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.techStackId = id;

    state = temp;
  }

  void setStudentInputSkillSet(
    List<int> skillSets,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.skillSets = [...skillSets];

    state = temp;
  }

  void setStudentInputLanguague(
    List<dynamic> languages,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.languages = [...languages];

    state = temp;
  }

  void addStudentInputLanguague(
    dynamic language,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.languages = [...temp.languages!, language];

    state = temp;
  }

  void updateStudentInputLanguague(String languageName, String level, int index) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.languages![index].languageName = languageName;
    temp.languages![index].level = level;

    state = temp;
  }

  void deleteStudentInputLanguague(int index) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.languages!.removeAt(index);

    state = temp;
  }

  //education
  void setStudentInputEducation(
    List<dynamic> educations,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.educations = [...educations];

    state = temp;
  }

  void addStudentInputEducation(
    dynamic educations,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.educations = [...temp.educations!, educations];

    state = temp;
  }

  void updateStudentInputEducation(String schoolName, String startYear, String endYear, int index) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.educations![index].schoolName = schoolName;
    temp.educations![index].startYear = startYear;
    temp.educations![index].endYear = endYear;

    state = temp;
  }

  void deleteStudentInputEducation(int index) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
    );

    temp.educations!.removeAt(index);

    state = temp;
  }
}

final studentInputProvider = StateNotifierProvider<StudentInputNotifier, StudentInput>((ref) => StudentInputNotifier());
