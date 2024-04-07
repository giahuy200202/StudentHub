import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentInput {
  String? fullname;
  int? techStackId;
  List<int>? skillSets;
  List<dynamic>? languages;
  List<dynamic>? educations;
  List<dynamic>? experiences;

  StudentInput({this.fullname, this.techStackId, this.skillSets, this.languages, this.educations, this.experiences});
}

class StudentInputNotifier extends StateNotifier<StudentInput> {
  StudentInputNotifier()
      : super(StudentInput(
          fullname: '',
          techStackId: 0,
          skillSets: [],
          languages: [],
          educations: [],
          experiences: [],
        ));

  void setStudentInputData(
    String fullname,
    int techStackId,
    List<int> skillSets,
    List<dynamic> languages,
    List<dynamic> educations,
    List<dynamic> experiences,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
    );

    temp.fullname = fullname;
    temp.techStackId = techStackId;
    temp.skillSets = [...skillSets];
    temp.languages = [...languages];
    temp.educations = [...educations];
    temp.experiences = [...experiences];

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
      experiences: [...state.experiences!],
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
      experiences: [...state.experiences!],
    );

    temp.skillSets = [...skillSets];

    state = temp;
  }

  //languages
  void setStudentInputLanguague(
    List<dynamic> languages,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
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
      experiences: [...state.experiences!],
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
      experiences: [...state.experiences!],
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
      experiences: [...state.experiences!],
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
      experiences: [...state.experiences!],
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
      experiences: [...state.experiences!],
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
      experiences: [...state.experiences!],
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
      experiences: [...state.experiences!],
    );

    temp.educations!.removeAt(index);

    state = temp;
  }

  //experiences
  void setStudentInputExperiences(
    List<dynamic> experiences,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
    );

    temp.experiences = [...experiences];

    state = temp;
  }

  void addStudentInputExperiences(
    dynamic experiences,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
    );

    temp.experiences = [...temp.experiences!, experiences];

    state = temp;
  }

  void updateStudentInputExperiences(
    String projectName,
    String startYear,
    String endYear,
    String duration,
    List<dynamic> skillset,
    int index,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
    );

    temp.educations![index].projectName = projectName;
    temp.educations![index].startYear = startYear;
    temp.educations![index].endYear = endYear;
    temp.educations![index].duration = duration;
    temp.educations![index].skillset = skillset;

    state = temp;
  }

  void deleteStudentInputExperiences(int index) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
    );

    temp.experiences!.removeAt(index);

    state = temp;
  }
}

final studentInputProvider = StateNotifierProvider<StudentInputNotifier, StudentInput>((ref) => StudentInputNotifier());
