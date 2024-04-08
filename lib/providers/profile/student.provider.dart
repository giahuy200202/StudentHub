import 'package:flutter_riverpod/flutter_riverpod.dart';

class Student {
  int? id;
  String? email;
  String? fullname;
  int? techStackId;
  List<int>? skillSets;
  List<dynamic>? languages;
  List<dynamic>? educations;
  List<dynamic>? experiences;
  String? resume;
  String? transcript;

  Student({
    this.id,
    this.fullname,
    this.email,
    this.techStackId,
    this.skillSets,
    this.educations,
    this.experiences,
    this.languages,
    this.resume,
    this.transcript,
  });
}

class StudentNotifier extends StateNotifier<Student> {
  StudentNotifier()
      : super(Student(
          id: 0,
          fullname: '',
          email: '',
          techStackId: 0,
          skillSets: [],
          educations: [],
          experiences: [],
          languages: [],
          resume: '',
          transcript: '',
        ));

  void setStudentData(
    int id,
    String fullname,
    String email,
    int techStackId,
    List<int> skillSets,
    List<dynamic> educations,
    List<dynamic> experiences,
    List<dynamic> languages,
  ) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      email: state.email,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      languages: [...state.languages!],
      resume: state.resume,
      transcript: state.transcript,
    );
    temp.id = id;
    temp.fullname = fullname;
    temp.email = email;
    temp.techStackId = techStackId;
    temp.skillSets = [...skillSets];
    temp.educations = [...educations];
    temp.experiences = [...experiences];
    temp.languages = [...languages];

    state = temp;
  }

  void setStudentId(
    int id,
  ) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      email: state.email,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      languages: [...state.languages!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.id = id;

    state = temp;
  }

  void setStudentFullname(
    String fullname,
  ) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      email: state.email,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      languages: [...state.languages!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.fullname = fullname;

    state = temp;
  }

  void setStudentTechstackId(
    int id,
  ) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      email: state.email,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      languages: [...state.languages!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.techStackId = id;

    state = temp;
  }

  void setStudentSkillSet(
    List<int> skillSets,
  ) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      email: state.email,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      languages: [...state.languages!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.skillSets = [...skillSets];

    state = temp;
  }

  void setStudentLanguague(
    List<dynamic> languages,
  ) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      email: state.email,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      languages: [...state.languages!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.languages = [...languages];

    state = temp;
  }

  void setStudentEducation(
    List<dynamic> educations,
  ) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      email: state.email,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      languages: [...state.languages!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.educations = [...educations];

    state = temp;
  }

  void setStudentResume(
    String resume,
  ) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      email: state.email,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      languages: [...state.languages!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.resume = resume;

    state = temp;
  }

  void setStudentTranscript(
    String transcript,
  ) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      email: state.email,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      languages: [...state.languages!],
      resume: state.resume,
      transcript: state.transcript,
    );

    temp.transcript = transcript;

    state = temp;
  }
}

final studentProvider = StateNotifierProvider<StudentNotifier, Student>((ref) => StudentNotifier());
