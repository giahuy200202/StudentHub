import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentInput {
  String? fullname;
  int? techStackId;
  List<int>? skillSets;
  List<dynamic>? languages;
  List<dynamic>? educations;
  List<dynamic>? experiences;
  List<int>? skillSetsForExp;
  String? resume;
  String? transcript;

  StudentInput({
    this.fullname,
    this.techStackId,
    this.skillSets,
    this.languages,
    this.educations,
    this.experiences,
    this.skillSetsForExp,
    this.resume,
    this.transcript,
  });
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
          skillSetsForExp: [],
          resume: '',
          transcript: '',
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      experiences: [...state.experiences!],
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.skillSets = [...skillSets];

    state = temp;
  }

  void setStudentInputSkillSetForExp(
    List<int> skillSetsForExp,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.skillSetsForExp = [...skillSetsForExp];

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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.educations = [...temp.educations!, educations];

    state = temp;
  }

  void updateStudentInputEducation(
    String schoolName,
    String startYear,
    String endYear,
    int index,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.experiences = [...temp.experiences!, experiences];

    state = temp;
  }

  void updateStudentInputExperiences(
    String title,
    String description,
    String startMonth,
    String endMonth,
    List<int> skillSets,
    int index,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.experiences![index].title = title;
    temp.experiences![index].description = description;
    temp.experiences![index].startMonth = startMonth;
    temp.experiences![index].endMonth = endMonth;
    temp.experiences![index].skillSets = [...skillSets];

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
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.experiences!.removeAt(index);

    state = temp;
  }

  void setStudentInputResume(
    String resume,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.resume = resume;

    state = temp;
  }

  void setStudentInputTranscript(
    String transcript,
  ) {
    StudentInput temp = StudentInput(
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: state.skillSets,
      languages: [...state.languages!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      skillSetsForExp: [...state.skillSetsForExp!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.transcript = transcript;

    state = temp;
  }
}

final studentInputProvider = StateNotifierProvider<StudentInputNotifier, StudentInput>((ref) => StudentInputNotifier());
