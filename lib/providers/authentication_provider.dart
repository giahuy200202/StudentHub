import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  String? id;
  String? name;
  String? role;

  User({
    this.id,
    this.name,
    this.role,
  });
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(User(
          id: '1',
          name: 'Pham Vo Cuong',
          role: 'student',
        ));

  // void setRole(String value) {
  //   User temp = User(
  //     id: state.id,
  //     name: state.name,
  //     role: state.role,
  //   );
  //   temp.role = value;
  //   state = temp;
  // }
}

final userProvider =
    StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());
