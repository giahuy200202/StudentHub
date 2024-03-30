import 'package:flutter_riverpod/flutter_riverpod.dart';

class Student {
  int? id;
  String? fullname;
  int? techStackId;
  List<int>? skillSets;

  Student({
    this.id,
    this.fullname,
    this.techStackId,
    this.skillSets,
  });
}

class StudentNotifier extends StateNotifier<Student> {
  StudentNotifier()
      : super(Student(id: 0, fullname: '', techStackId: 0, skillSets: []));

  void setStudentData(
      int id, String fullname, int techStackId, List<int> skillSets) {
    Student temp = Student(
      id: state.id,
      fullname: state.fullname,
      techStackId: state.techStackId,
      skillSets: [...state.skillSets!],
    );
    temp.id = id;
    temp.fullname = fullname;
    temp.techStackId = techStackId;
    temp.skillSets = [...skillSets];
    state = temp;
  }
}

final studentProvider =
    StateNotifierProvider<StudentNotifier, Student>((ref) => StudentNotifier());
