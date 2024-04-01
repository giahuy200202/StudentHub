import 'package:flutter_riverpod/flutter_riverpod.dart';

class Student {
  int? id;
  String? fullname;
  String? email;
  int? techStackId;
  List<int>? skillSets;
  List<dynamic>? educations;
  List<dynamic>? experiences;
  List<dynamic>? languages;

  Student({
    this.id,
    this.fullname,
    this.email,
    this.techStackId,
    this.skillSets,
    this.educations,
    this.experiences,
    this.languages,
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
            languages: []));

  void setStudentData(
      int id,
      String fullname,
      String email,
      int techStackId,
      List<int> skillSets,
      List<dynamic> educations,
      List<dynamic> experiences,
      List<dynamic> languages) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      email: state.email,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
      educations: [...state.educations!],
      experiences: [...state.experiences!],
      languages: [...state.languages!],
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
}

final studentProvider =
    StateNotifierProvider<StudentNotifier, Student>((ref) => StudentNotifier());
